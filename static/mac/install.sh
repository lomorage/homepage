#!/usr/bin/env bash
#
# One-click installer for lomod (lomorage's personal photo backup backend) on macOS.
#
# Intended to be run the same way Claude Code's own installer is:
#
#     curl -fsSL https://lomorage.com/mac/install.sh | bash
#
# This installs the current lomod backend with a browser setup flow.
# Installation instructions are at https://lomorage.com/#download.
# It comes with Lomorage.app, a menu bar
# icon (see its Contents/MacOS/lomorage-tray.swift header comment) mirroring the Windows
# installer's system tray icon, for open/start/stop/restart/reset without a terminal --
# installed to ~/Applications so a non-technical user who quits the tray can find and reopen it
# via Spotlight/Launchpad like any normal Mac app, rather than needing Terminal or a reboot.
#
# Everything here runs at the current user's permission level -- no sudo, no admin rights, no
# system LaunchDaemon. It installs into ~/Library/Application Support, autostarts via a
# per-user LaunchAgent (RunAtLoad, KeepAlive only on a crash/nonzero exit -- so a deliberate
# Quit from the tray, which exits cleanly, stays stopped until next login/manual restart same
# as the Windows Startup-folder shortcut, but an unexpected crash self-heals), and defaults to
# a single local backup folder with mDNS disabled so first run doesn't trigger a macOS firewall
# prompt.
#
# Safe to re-run: it stops any already-running lomod, replaces the install directory, and
# restarts it, so this script also serves as a manual repair/reinstall/update path pending a
# scheduled self-update wired on top of cmd/lomoupg.
#
# Flags (all optional; env vars of the same name in SCREAMING_SNAKE_CASE also work):
#   --install-dir <dir>    Where lomod and its bundled dependencies (vips/ffmpeg dylibs,
#                           exiftool) are installed. Default: ~/Library/Application Support/Lomorage/lomod
#   --data-dir <dir>       Where photos/videos and the sqlite catalog are stored (the "single
#                           local folder" desktop mode -- no Samba/USB-mount/mDNS features).
#                           Default: ~/Pictures/Lomorage
#   --release-url <url>    Where to fetch the release manifest (see installers/release.json.example
#                           for the schema). Default: https://lomorage.com/release.json -- the
#                           same production manifest LomoAgent's own updater uses, but this
#                           script reads its own 'macos-cli-<arch>' key, never the 'darwin' key
#                           LomoAgent itself uses, so the two installers' release info can
#                           never collide.
#   --manifest-key <key>   Which top-level key of the release manifest to read. Default:
#                           macos-cli-arm64 or macos-cli-amd64, chosen from `uname -m`.
#   --port <port>          Default: 8000
#   --no-browser           Skip auto-opening the default browser to the local setup UI after install.
#
# LOMOD_CHINA=1  Route the release tarball download through https://gfw.lomorage.com/<url>
#                instead of directly from GitHub Releases -- same accelerator proxy already used
#                for the zh download links on lomosw.github.io (LomoAgentWin/LomoAgentOSX/
#                Android/pi-gen etc), since GitHub Releases asset downloads are often slow or
#                unreachable from mainland China otherwise. Mirrors installers/windows/
#                install.ps1's $env:LOMOD_CHINA. Only the tarball download is affected -- the
#                release manifest fetch (--release-url) already goes to lomorage.com's own
#                domain, not GitHub. No --china flag (env var only): this script is normally
#                invoked as `curl | bash`, which has no clean way to pass flags through the pipe,
#                but a var set on the right-hand command of a pipeline is visible to it:
#                    curl -fsSL https://lomorage.com/mac/install.sh | LOMOD_CHINA=1 bash
set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-${HOME}/Library/Application Support/Lomorage/lomod}"
DATA_DIR="${DATA_DIR:-${HOME}/Pictures/Lomorage}"
RELEASE_URL="${RELEASE_URL:-https://lomorage.com/release.json}"
MANIFEST_KEY="${MANIFEST_KEY:-}"
PORT="${PORT:-8000}"
NO_BROWSER="${NO_BROWSER:-}"
CHINA="${LOMOD_CHINA:-}"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --install-dir) INSTALL_DIR="$2"; shift 2 ;;
        --data-dir) DATA_DIR="$2"; shift 2 ;;
        --release-url) RELEASE_URL="$2"; shift 2 ;;
        --manifest-key) MANIFEST_KEY="$2"; shift 2 ;;
        --port) PORT="$2"; shift 2 ;;
        --no-browser) NO_BROWSER=1; shift ;;
        *) echo "unknown argument: $1" >&2; exit 1 ;;
    esac
done

LABEL="com.lomorage.lomod"
PLIST_PATH="${HOME}/Library/LaunchAgents/${LABEL}.plist"
APP_PATH="${HOME}/Applications/Lomorage.app"

step() { printf '\033[36m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[33m!!\033[0m %s\n' "$1" >&2; }
fail() { printf '\033[31mInstall failed:\033[0m %s\n' "$1" >&2; exit 1; }

case "$(uname -s)" in
    Darwin) ;;
    *) fail "this installer is for macOS only" ;;
esac

ARCH_RAW="$(uname -m)"
case "${ARCH_RAW}" in
    arm64) ARCH="arm64" ;;
    x86_64) ARCH="amd64" ;;
    *) warn "unrecognized architecture '${ARCH_RAW}', assuming amd64"; ARCH="amd64" ;;
esac
if [[ -z "${MANIFEST_KEY}" ]]; then
    MANIFEST_KEY="macos-cli-${ARCH}"
fi

if ! command -v python3 >/dev/null 2>&1; then
    fail "python3 is required to parse the release manifest but wasn't found (install Xcode Command Line Tools: xcode-select --install)"
fi

sha256_hex() {
    shasum -a 256 "$1" | awk '{print $1}'
}

manifest_field() {
    printf '%s' "${MANIFEST_JSON}" | python3 -c '
import json, sys
data = json.load(sys.stdin)
platform = data.get(sys.argv[1])
if not platform:
    sys.exit(1)
val = platform.get(sys.argv[2])
if val is None:
    sys.exit(1)
print(val)
' "${MANIFEST_KEY}" "$1"
}

stop_existing_lomod() {
    local stop_script="${INSTALL_DIR}/lomorage-stop.sh"
    if [[ -x "${stop_script}" ]]; then
        step "Stopping any running lomod"
        "${stop_script}" || true
    fi
    # Also stop any running tray -- lomorage-stop.sh only kills lomod, but the tray process
    # itself has no logic to notice its lomod died and restart it. Left alive across a
    # reinstall, the NEW instance register_autostart is about to launch would see the OLD tray
    # still matching its singleton-guard pgrep and exit immediately assuming it's redundant,
    # even though the lomod it was supposed to be minding just got killed out from under it --
    # leaving nothing running at all. Matches "safe to re-run" for the tray, not just lomod.
    pkill -f "${APP_PATH}/Contents/MacOS/lomorage-launcher" 2>/dev/null || true
    sleep 1
}

# Installs the Lomorage.app wrapper (shipped as a static template inside the release tarball,
# see its Contents/MacOS/lomorage-tray.swift header comment) into ~/Applications so it's
# findable via Spotlight/Launchpad/Finder, then points it at this INSTALL_DIR via
# install-dir.txt -- the app bundle itself never embeds a copy of the actual tray logic, so it
# doesn't need reinstalling on every lomod update, only when the compiled binary itself
# changes. Returns non-zero (caller falls back to starting lomod directly, headless) if the
# release tarball didn't include the template, e.g. an older release.
install_app_bundle() {
    local template="${INSTALL_DIR}/Lomorage.app"
    if [[ ! -d "${template}" ]]; then
        return 1
    fi
    mkdir -p "$(dirname "${APP_PATH}")"
    rm -rf "${APP_PATH}"
    cp -R "${template}" "${APP_PATH}"
    # Deliberately NOT written inside the bundle (e.g. Contents/Resources/): mutating a signed
    # .app after the fact invalidates its code signature seal. This path must match the one
    # lomorage-launcher reads.
    mkdir -p "${HOME}/Library/Application Support/Lomorage"
    printf '%s' "${INSTALL_DIR}" > "${HOME}/Library/Application Support/Lomorage/tray-install-dir.txt"
}

register_autostart() {
    mkdir -p "$(dirname "${PLIST_PATH}")"
    # Prefer launching the Lomorage.app wrapper (which starts lomod itself on launch -- see
    # lomorage-tray.swift's header comment) so a single autostart entry brings back the server,
    # the menu bar icon, AND a normal double-click-to-reopen Mac app; fall back to starting
    # lomod directly, headless, if the app bundle is missing (e.g. an older release tarball
    # extracted over a partial/interrupted install).
    if [[ -x "${APP_PATH}/Contents/MacOS/lomorage-launcher" ]]; then
        PROGRAM_ARGUMENTS="<string>${APP_PATH}/Contents/MacOS/lomorage-launcher</string>"
        PROCESS_TYPE="Interactive"
    else
        PROGRAM_ARGUMENTS="<string>${INSTALL_DIR}/lomorage-start.sh</string>"
        PROCESS_TYPE="Background"
    fi
    cat > "${PLIST_PATH}" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        ${PROGRAM_ARGUMENTS}
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <dict>
        <key>SuccessfulExit</key>
        <false/>
    </dict>
    <key>ProcessType</key>
    <string>${PROCESS_TYPE}</string>
</dict>
</plist>
PLIST
    launchctl bootout "gui/$(id -u)/${LABEL}" >/dev/null 2>&1 || true
    launchctl bootstrap "gui/$(id -u)" "${PLIST_PATH}"
}

wait_for_lomod() {
    # No -f: a fresh, not-yet-onboarded lomod legitimately answers /mount with a 500
    # ("Device is not mounted yet") until the user finishes the /welcome setup flow in the
    # browser -- -f would treat that as a failed health check even though the server is up and
    # responding correctly. Without -f, curl still exits non-zero for an actual connection
    # failure (nothing listening yet, timeout), which is the only thing this loop needs to poll.
    local timeout=30 start_ts now_ts
    start_ts="$(date +%s)"
    while true; do
        if curl -sS -o /dev/null --max-time 2 "http://127.0.0.1:${PORT}/mount" 2>/dev/null; then
            return 0
        fi
        now_ts="$(date +%s)"
        if (( now_ts - start_ts >= timeout )); then
            return 1
        fi
        sleep 0.5
    done
}

trap 'fail "unexpected error on line $LINENO"' ERR

step "Fetching release manifest from ${RELEASE_URL}"
MANIFEST_JSON="$(curl -fsSL "${RELEASE_URL}")" || fail "could not fetch ${RELEASE_URL}"

PLATFORM_URL="$(manifest_field URL)" || fail "release manifest at ${RELEASE_URL} has no usable '${MANIFEST_KEY}' entry (expected URL/SHA256/Version fields, see installers/release.json.example)"
PLATFORM_SHA256="$(manifest_field SHA256)" || fail "release manifest entry '${MANIFEST_KEY}' is missing SHA256"
PLATFORM_VERSION="$(manifest_field Version)" || fail "release manifest entry '${MANIFEST_KEY}' is missing Version"

stop_existing_lomod

DOWNLOAD_URL="${PLATFORM_URL}"
CHINA_SUFFIX=""
if [[ -n "${CHINA}" ]]; then
    DOWNLOAD_URL="https://gfw.lomorage.com/${PLATFORM_URL}"
    CHINA_SUFFIX=" via gfw.lomorage.com proxy"
fi

step "Downloading lomod ${PLATFORM_VERSION}${CHINA_SUFFIX}"
TMP_DIR="$(mktemp -d -t lomorage-macos)"
trap 'rm -rf "${TMP_DIR}"' EXIT
TMP_TARBALL="${TMP_DIR}/lomorage-macos-${PLATFORM_VERSION}.tar.gz"
curl -fsSL -o "${TMP_TARBALL}" "${DOWNLOAD_URL}" || fail "download of ${DOWNLOAD_URL} failed"

# lowercase via tr, not bash 4's ${var,,}: macOS ships bash 3.2 (Apple stopped updating bash
# at the last GPLv2 release), which doesn't support that expansion.
ACTUAL_SHA256="$(sha256_hex "${TMP_TARBALL}" | tr 'A-Z' 'a-z')"
EXPECTED_SHA256="$(printf '%s' "${PLATFORM_SHA256}" | tr 'A-Z' 'a-z')"
if [[ "${ACTUAL_SHA256}" != "${EXPECTED_SHA256}" ]]; then
    fail "downloaded file does not match the expected SHA256 in the release manifest.
expected: ${EXPECTED_SHA256}
actual:   ${ACTUAL_SHA256}
This could mean a corrupted download or a tampered release -- aborting."
fi

step "Installing to ${INSTALL_DIR}"
# Wipe before extracting, not just overwrite in place: INSTALL_DIR holds only program files
# (lomod and its bundled deps) never user data (that's DATA_DIR, a separate location), so
# nothing of value is lost -- but tar extracting into an already-populated directory leaves
# behind any file that existed in an older release and doesn't exist in the new one. That's
# usually harmless, except for a signed bundle like Lomorage.app: an older release's signature
# scheme can leave stray files (e.g. detached Contents/_CodeSignature/CodeDirectory et al,
# from back when lomorage-launcher was a shell script instead of a compiled binary) sitting
# alongside the new release's differently-shaped signature, which Gatekeeper then rejects
# wholesale as "unsealed contents present in the bundle root" -- macOS shows that to the user
# as a confusing, unrelated-looking "\"Lomorage\" is damaged and can't be opened" dialog.
rm -rf "${INSTALL_DIR}"
mkdir -p "${INSTALL_DIR}"
tar -xzf "${TMP_TARBALL}" -C "${INSTALL_DIR}"
chmod +x "${INSTALL_DIR}/lomod" "${INSTALL_DIR}/lomorage-start.sh" "${INSTALL_DIR}/lomorage-stop.sh"

printf '%s' "${PLATFORM_VERSION}" > "${INSTALL_DIR}/version.txt"

mkdir -p "${DATA_DIR}"
cat > "${INSTALL_DIR}/lomod.args" <<ARGS
LOMOD_ARGS=(--base "${DATA_DIR}" --exe-dir "${INSTALL_DIR}" --no-mdns --port ${PORT})
ARGS

install_app_bundle || true

step "Registering autostart (per-user, no admin required)"
register_autostart

step "Starting lomod"
if wait_for_lomod; then
    echo ""
    echo -e "\033[32mlomorage is running: http://localhost:${PORT}\033[0m"
    echo "  install dir: ${INSTALL_DIR}"
    echo "  data dir:    ${DATA_DIR}"
    echo "  it will start automatically next time you log in"
    if [[ -x "${APP_PATH}/Contents/MacOS/lomorage-launcher" ]]; then
        echo "  a Lomorage icon is in the menu bar -- use it to open/stop/restart/reset"
        echo "  quit it by accident? reopen \"Lomorage\" from Spotlight, Launchpad, or ~/Applications"
    else
        echo "  to stop it, run: ${INSTALL_DIR}/lomorage-stop.sh"
    fi
    if [[ -z "${NO_BROWSER}" ]]; then
        open "http://localhost:${PORT}" || true
    fi
else
    warn "lomod was installed and launched, but didn't respond on http://localhost:${PORT} within 30s. Check that nothing else is using that port, or run ${INSTALL_DIR}/lomod directly from a terminal to see its output."
fi
