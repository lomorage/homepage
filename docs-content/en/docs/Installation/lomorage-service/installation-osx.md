---
title: OSX
weight: 5
---

# Install "Lomorage Photo Assistant" on macOS

## 1. Install

Open **Terminal** (no `sudo` needed) and run:

```bash
curl -fsSL https://lomorage.com/mac/install.sh | bash
```

This downloads `lomod` and everything it needs (vips, exiftool, ffmpeg), installs it to your
user profile, and starts it — no `.dmg`, no admin password, no reboot.

{{< hint warning >}}
If you're in mainland China and GitHub downloads are slow or fail, route the download through
an accelerator proxy instead:

```bash
curl -fsSL https://lomorage.com/mac/install.sh | LOMOD_CHINA=1 bash
```
{{< /hint >}}

If macOS shows a firewall or network-access prompt the first time it starts (so your phone can
reach it over your local network), click **Allow**.

## 2. Data folder

By default, your photos and videos are stored under `Pictures/Lomorage` in your own home
folder — you don't need to configure anything before using it.

If you'd rather use a different drive or folder (for example an external drive), download the
script first instead of piping it straight into `bash`, then run it with `--data-dir`:

```bash
curl -fsSL https://lomorage.com/mac/install.sh -o install.sh
chmod +x install.sh
./install.sh --data-dir "/Volumes/MyDrive/Lomorage"
```

Running the installer again like this is also how you re-point an existing install at a new
folder — it's safe to re-run any time.

## 3. Open Lomorage

A **Lomorage** icon appears in your menu bar, and a **Lomorage** app is added to
`~/Applications` — find it with Spotlight (⌘Space, type "Lomorage") or Launchpad like any other
Mac app, and double-click to open the web client in your browser.

Click the menu bar icon for **Start / Stop / Restart**, or **Quit** to close it entirely. If
you ever quit it, reopen it the same way — via Spotlight, Launchpad, or `~/Applications` — no
need to reinstall.

## 4. Access from your phone or another computer

Find the IP address shown for your Mac, then from your phone or another device on the same
network, open `http://<that-ip>:8000` in a browser.

## 5. Staying up to date

Automatic background updates aren't wired up on macOS yet. To update, just run the install
command from step 1 again — it's safe to re-run and won't touch your photos.

## 6. Uninstall

There isn't a one-click uninstaller yet. To remove it completely:

1. Click the menu bar icon and choose **Quit**.
2. Delete `~/Applications/Lomorage.app`.
3. Run `launchctl bootout gui/$(id -u)/com.lomorage.lomod` and delete
   `~/Library/LaunchAgents/com.lomorage.lomod.plist`.
4. Delete the install folder at `~/Library/Application Support/Lomorage/lomod`.

Your photos in the data folder from step 2 are not touched by any of this.

Enjoy!

**Contact us: support@lomorage.com**
