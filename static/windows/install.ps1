<#
.SYNOPSIS
  One-click installer for lomod (lomorage's personal photo backup backend) on Windows.

.DESCRIPTION
  Intended to be run the same way Claude Code's own installer is:

      irm https://lomorage.com/windows/install.ps1 | iex

  This installs the current lomod backend and its bundled tray helper.
  Installation instructions are at https://lomorage.com/#download.

  Everything here runs at the current user's permission level -- no UAC prompt, no admin
  rights, no Windows Service. It installs into %LOCALAPPDATA%, autostarts via a shortcut in
  the per-user Startup folder (not the Windows Service Control Manager or an elevated
  Scheduled Task, both of which require elevation), adds a Start Menu shortcut too (so
  reopening it after a Quit is "search Lomorage, press Enter" -- no PowerShell, no hunting
  through %LOCALAPPDATA%, same as any other installed app), and defaults to a single local
  backup folder with mDNS disabled so first run doesn't trigger a Windows Firewall prompt.

  Safe to re-run: it stops any already-running lomod.exe, replaces the install directory, and
  restarts it, so this script also serves as a manual repair/reinstall/update path. A daily,
  per-user Scheduled Task (see Register-Autoupdate / lomorage-update.ps1) additionally checks
  for and installs new releases automatically, no admin rights required.

.PARAMETER InstallDir
  Where lomod.exe and its bundled dependencies (vips DLLs, exiftool.exe, ffmpeg.exe/ffprobe.exe)
  are installed. Defaults to a per-user, admin-free location.

.PARAMETER DataDir
  Where photos/videos and the sqlite catalog are stored. Defaults to a local Pictures subfolder
  (the "single local folder" desktop mode -- no Samba/USB-mount/mDNS features).

.PARAMETER ReleaseUrl
  Where to fetch the release manifest (see installers/release.json.example for the schema).
  Defaults to the real production manifest also used by LomoAgent's own updater
  (homepage/static/release.json, deployed to https://lomorage.com/release.json) -- but this
  script reads a distinct -ManifestKey within it, never the "windows" key LomoAgent itself uses,
  so the two installers' release info can never collide.

.PARAMETER ManifestKey
  Which top-level key of the release manifest to read. Defaults to "windows-cli" (kept separate
  from LomoAgent's own "windows" key -- see homepage/updatever.sh's `wincli` platform option).

.PARAMETER NoBrowser
  Skip auto-opening the default browser to the local setup UI after install.

.NOTES
  Set $env:LOMOD_CHINA=1 before running to fetch the release zip through
  https://gfw.lomorage.com/<url> (lomorage's GitHub download accelerator proxy) instead of
  directly from GitHub Releases, since GitHub Releases asset downloads are often slow or
  unreachable from mainland China otherwise. Only the zip download is affected -- the release manifest fetch
  (-ReleaseUrl) already goes to lomorage.com's own domain, not GitHub. An env var rather than a
  -China switch because this script is normally invoked as `irm ... | iex`, which has no way to
  pass switch/positional arguments through the pipe; an env var set beforehand is visible to the
  script once iex evaluates it in the current scope:
      $env:LOMOD_CHINA=1; irm https://lomorage.com/windows/install.ps1 | iex
#>
param(
    [string]$InstallDir = (Join-Path $env:LOCALAPPDATA "Lomorage\lomod"),
    [string]$DataDir = (Join-Path $env:USERPROFILE "Pictures\Lomorage"),
    [string]$ReleaseUrl = "https://lomorage.com/release.json",
    [string]$ManifestKey = "windows-cli",
    [int]$Port = 8000,
    [switch]$NoBrowser
)

$ErrorActionPreference = "Stop"
$China = $env:LOMOD_CHINA -eq "1"

function Write-Step($msg) { Write-Host "==> $msg" -ForegroundColor Cyan }
function Write-Warn2($msg) { Write-Host "!! $msg" -ForegroundColor Yellow }

function Get-Sha256Hex {
    # Not Get-FileHash: on some machines PSModulePath ordering resolves Microsoft.PowerShell.Utility
    # to an incompatible PowerShell-7-targeted copy from a WindowsApps package, silently breaking
    # Get-FileHash under Windows PowerShell 5.1. Raw .NET has no module-resolution dependency.
    param([string]$Path)
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    try {
        $stream = [System.IO.File]::OpenRead($Path)
        try { $hashBytes = $sha256.ComputeHash($stream) } finally { $stream.Close() }
    } finally {
        $sha256.Dispose()
    }
    return -join ($hashBytes | ForEach-Object { $_.ToString("x2") })
}

function Get-VerifiedFile {
    param([string]$Url, [string]$ExpectedSha256, [string]$OutFile)
    # curl.exe (built into Windows 10 1803+), not Invoke-WebRequest: some hosts (e.g. SourceForge's
    # Cloudflare bot-protection) serve Invoke-WebRequest an HTML page instead of the real file.
    & curl.exe -fsSL -o $OutFile $Url
    if ($LASTEXITCODE -ne 0) { throw "curl.exe failed downloading $Url (exit $LASTEXITCODE)" }
    $actual = Get-Sha256Hex -Path $OutFile
    if ($actual.ToLower() -ne $ExpectedSha256.ToLower()) {
        throw "Downloaded file $OutFile does not match the expected SHA256 in the release manifest.`nexpected: $ExpectedSha256`nactual:   $actual`nThis could mean a corrupted download or a tampered release -- aborting."
    }
}

function Stop-ExistingLomod {
    $stopScript = Join-Path $InstallDir "lomorage-stop.bat"
    if (Test-Path $stopScript) {
        Write-Step "Stopping any running lomod.exe"
        # Start-Process, not `& cmd /c ... | Out-Null`: piping through the pipeline blocks until
        # the pipe sees EOF, which never happens if a detached long-running child (lomod.exe)
        # inherits the same stdout handle. Start-Process with no output redirection has no such
        # handle to inherit, so -Wait only waits on cmd.exe's own exit, not any grandchildren.
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "`"$stopScript`"" -WindowStyle Hidden -Wait
        Start-Sleep -Seconds 1
    }
}

function New-LomorageShortcut {
    # Shared by Register-Autostart and Register-StartMenuShortcut: both point at
    # lomorage-tray.ps1, not lomorage-start.bat directly, since the tray script starts
    # lomod.exe itself (if not already running) and also puts a notification-area icon up with
    # Open/Start/Stop/Restart, so one shortcut covers both "run automatically" and "reopen it by
    # hand" -- neither needs to know or care whether lomod is already running.
    # lomorage-start.bat still exists unchanged for lomoupg's --precmd/--postcmd self-update
    # hooks, which don't go through this at all.
    param([string]$Path, [string]$Description)

    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($Path)
    $shortcut.TargetPath = (Get-Command powershell.exe).Source
    $shortcut.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$(Join-Path $InstallDir 'lomorage-tray.ps1')`""
    $shortcut.WorkingDirectory = $InstallDir
    $shortcut.WindowStyle = 7  # minimized (only matters for the brief instant before -WindowStyle Hidden takes over)
    $shortcut.Description = $Description
    $iconPath = Join-Path $InstallDir "lomorage.ico"
    if (Test-Path $iconPath) { $shortcut.IconLocation = $iconPath }
    $shortcut.Save()
}

function Register-Autostart {
    $startupDir = [Environment]::GetFolderPath("Startup")
    New-LomorageShortcut -Path (Join-Path $startupDir "Lomorage.lnk") `
        -Description "Lomorage tray icon (starts lomod, lets you open/stop/restart it)"
}

function Register-StartMenuShortcut {
    # A non-technical user's actual path back into the app once the tray icon is gone --
    # Quit in the tray menu closes it with no other visible trace, and the Startup-folder
    # shortcut Register-Autostart makes is deliberately hidden (that's the point of an
    # autostart entry). Windows key -> type "Lomorage" -> Enter is the one launch path every
    # Windows user already knows, same as any other installed app -- no PowerShell, no
    # digging through %LOCALAPPDATA%, no remembering a .bat filename.
    $startMenuDir = [Environment]::GetFolderPath("Programs")
    New-LomorageShortcut -Path (Join-Path $startMenuDir "Lomorage.lnk") `
        -Description "Open Lomorage (starts it if it isn't already running)"
}

function Register-Autoupdate {
    # Per-user, non-admin Scheduled Task -- LogonType Interactive + RunLevel Limited is exactly
    # what a standard user can already do at their own privilege level, same as everything else
    # in this script; it does not need (and will not prompt for) elevation.
    $taskName = "LomorageUpdate"
    $updateScript = Join-Path $InstallDir "lomorage-update.ps1"

    $action = New-ScheduledTaskAction -Execute "powershell.exe" `
        -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$updateScript`""

    # Daily only -- no AtLogOn trigger: tested on this machine, adding one makes
    # Register-ScheduledTask fail with a bare "Access is denied" regardless of Principal/
    # RunLevel (looks like local policy blocking logon-triggered task creation without
    # elevation, a common anti-persistence hardening setting -- Daily triggers aren't
    # affected). -StartWhenAvailable below covers most of the same gap: a laptop that's
    # asleep at 3:15am runs the missed trigger as soon as it's next on, not just next login.
    $dailyTrigger = New-ScheduledTaskTrigger -Daily -At "3:15AM"
    $dailyTrigger.RandomDelay = "PT30M"

    # DOMAIN\User (or COMPUTERNAME\User), not a bare username: Register-ScheduledTask fails
    # with a bare "Access is denied" against just $env:USERNAME.
    $principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Limited
    $settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable `
        -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $dailyTrigger `
        -Principal $principal -Settings $settings `
        -Description "Checks for and installs lomod CLI updates (lomorage-update.ps1). Per-user, no admin rights." `
        | Out-Null
}

function Wait-ForLomod {
    # Polls /status, not /mount: /mount needs a token once a user has been created (401 "Invalid
    # Token"), so re-running this script over an existing setup -- the documented
    # reinstall/repair/update path -- waited out the full timeout and then warned that lomod never
    # came up. /status needs no token in any state and answers 200 with a bare numeric system
    # status. Requiring that numeric body, not just any response, keeps some other web server
    # already listening on $Port from passing as lomod.
    param([int]$TimeoutSeconds = 30)
    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    while ((Get-Date) -lt $deadline) {
        try {
            $resp = Invoke-WebRequest -Uri "http://127.0.0.1:$Port/status" -UseBasicParsing -TimeoutSec 2
            if ($resp.StatusCode -eq 200 -and "$($resp.Content)".Trim() -match '^\d+$') { return $true }
        } catch {}
        Start-Sleep -Milliseconds 500
    }
    return $false
}

try {
    $arch = $env:PROCESSOR_ARCHITECTURE
    if ($arch -ne "AMD64") {
        Write-Warn2 "Only a Windows amd64 build of lomod is published today (detected $arch). It may still run under Windows-on-ARM x64 emulation, but this is untested."
    }

    Write-Step "Fetching release manifest from $ReleaseUrl"
    $manifest = Invoke-RestMethod -Uri $ReleaseUrl
    $platform = $manifest.$ManifestKey
    if (-not $platform -or -not $platform.URL -or -not $platform.SHA256) {
        throw "Release manifest at $ReleaseUrl has no usable '$ManifestKey' entry (expected URL + SHA256 fields, see installers/release.json.example)."
    }

    Stop-ExistingLomod

    $downloadUrl = if ($China) { "https://gfw.lomorage.com/$($platform.URL)" } else { $platform.URL }
    Write-Step "Downloading lomod $($platform.Version)$(if ($China) { ' via gfw.lomorage.com proxy' })"
    $tmpZip = Join-Path $env:TEMP "lomorage-windows-$($platform.Version).zip"
    Get-VerifiedFile -Url $downloadUrl -ExpectedSha256 $platform.SHA256 -OutFile $tmpZip

    Write-Step "Installing to $InstallDir"
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
    Expand-Archive -Path $tmpZip -DestinationPath $InstallDir -Force
    Remove-Item $tmpZip -Force

    Set-Content -Path (Join-Path $InstallDir "version.txt") -Value $platform.Version -NoNewline

    New-Item -ItemType Directory -Force -Path $DataDir | Out-Null
    $lomodArgs = "--base `"$DataDir`" --exe-dir `"$InstallDir`" --no-mdns --port $Port"
    Set-Content -Path (Join-Path $InstallDir "lomod.args") -Value $lomodArgs -NoNewline

    Write-Step "Registering autostart (per-user, no admin required)"
    Register-Autostart
    Register-StartMenuShortcut

    Write-Step "Registering daily auto-update check (per-user, no admin required)"
    try {
        Register-Autoupdate
    } catch {
        Write-Warn2 "Could not register the auto-update Scheduled Task: $($_.Exception.Message). lomod will still run fine -- re-run this installer manually to update."
    }

    Write-Step "Starting lomod and the tray icon"
    # No -Wait: this launches the tray script (which starts lomod.exe itself) and returns
    # immediately -- both processes keep running detached. Wait-ForLomod below is the actual
    # readiness signal we need anyway.
    Start-Process -FilePath "powershell.exe" -ArgumentList "-WindowStyle", "Hidden", "-ExecutionPolicy", "Bypass", "-File", "`"$(Join-Path $InstallDir 'lomorage-tray.ps1')`"" -WindowStyle Hidden

    if (Wait-ForLomod) {
        Write-Host ""
        Write-Host "lomorage is running: http://localhost:$Port" -ForegroundColor Green
        Write-Host "  install dir: $InstallDir"
        Write-Host "  data dir:    $DataDir"
        Write-Host "  it will start automatically next time you log in"
        Write-Host "  to reopen it by hand: search for 'Lomorage' in the Start menu"
        Write-Host "  to stop it: right-click the Lomorage tray icon and choose Stop (or Quit)"
        if (-not $NoBrowser) {
            Start-Process "http://localhost:$Port"
        }
    } else {
        Write-Warn2 "lomod was installed and launched, but didn't respond on http://localhost:$Port within 30s. Check that nothing else is using that port, or run $InstallDir\lomod.exe directly from a terminal to see its output."
    }
} catch {
    Write-Host ""
    Write-Host "Install failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
