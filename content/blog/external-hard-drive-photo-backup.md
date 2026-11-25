+++
title = "Backing Up Photos to an External Hard Drive: A Practical Guide"
description = "How to back up family photos to an external hard drive the right way: choosing a drive, file systems, folder organization, automating backups and avoiding data loss."
tags = ["external hard drive", "photo backup", "redundancy", "Hard Disk"]
categories = ["Guides"]
date = "2026-11-25"
banner = "/img/blog/set_wd_as_backup/set_wd_as_backup.jpg"
related = ["321-backup-family-photos", "raspberry-pi-photo-server", "set_wd_as_backup"]

[[faq]]
q = "Is an external hard drive a good way to back up photos?"
a = "Yes, as one part of a plan. External drives are inexpensive and you control them, but any single drive can fail, so keep at least one more copy on a separate device."

[[faq]]
q = "Which file system should I use for a photo backup drive?"
a = "Use what your computer supports best: NTFS for Windows, APFS for Mac, or exFAT if the drive moves between both. Lomorage on Raspberry Pi supports vfat, exfat, ext2/3/4, hfsplus and ntfs, so you don't need to reformat an existing drive."

[[faq]]
q = "How long do external hard drives last?"
a = "Commonly several years, but it varies by model and use. Plan to replace drives before they get old, and check your backup regularly so you notice problems early."
+++

An external hard drive is the most common photo "backup" — and the most commonly forgotten one. A drive copied once two years ago and left in a drawer isn't really a backup. Here's how to use external drives so they actually protect your family's photos.

<!--more-->

## Choosing a drive

- **Capacity:** at least 2–3× the size of your current library, so you have room to grow for several years.
- **Desktop vs portable:** desktop (3.5") drives have their own power and are good for an always-connected backup; portable (2.5") drives are good for rotating off-site.
- **SSD vs HDD:** SSDs are faster and more shock-resistant; HDDs are cheaper per terabyte. Either works for photos.
- **Buy two.** One drive is a single point of failure.

## File systems

| File system | Best for |
| --- | --- |
| NTFS | Windows |
| APFS | Mac |
| exFAT | Moving between Windows and Mac |

You don't have to reformat a drive that already has files. Lomorage on Windows and Mac uses whatever the operating system supports, and on Raspberry Pi it supports vfat, exfat, ext2/3/4, hfsplus and ntfs ([FAQ](/faq/#what-file-systems-supported)).

## Organize by date, not by memory

Folders like "Photos new", "Phone backup 2", "Final final" quickly become impossible. Organize by **year/month/day**. Lomorage does this automatically — backed-up originals are stored as ordinary files in date-based folders, so the drive stays readable even without the app. (Dates are stored in UTC; see the [FAQ](/faq/#why-folders-named-with-date-time-seem-not-correct-on-hard-drive).)

## Stop copying by hand

Manual copying works only as long as you remember. Instead:

1. Connect the drive to a computer, NAS or [Raspberry Pi](/blog/2026/11/25/raspberry-pi-photo-server/) that's usually on.
2. Install [Lomorage](/) and choose that drive as storage — the app recommends the drive with the most free space.
3. Phones back up automatically over Wi-Fi on the schedule you choose.

## Add the second copy

Attach another drive as a **redundancy backup**:

- On Raspberry Pi: [secondary backup guide](/blog/2019/12/24/raspberrypi-hd/)
- On Windows with a network drive: [WD MyCloud as a backup disk](/blog/2023/02/22/set_wd_as_backup/)
- On macOS: set redundancy backup in LomoAgent settings

Then keep a third copy away from home — see [the 3-2-1 rule](/blog/2026/11/24/321-backup-family-photos/).

## Habits that prevent loss

- **Check every few months:** open a few old and new photos and videos from each drive.
- **Eject safely** before unplugging.
- **Let drives sleep.** Lomorage supports hard drive sleep and wakes the drive when needed.
- **Replace aging drives** before they fail. When it's time to upgrade, follow the [migration guide](/blog/2023/03/02/migrate_from_pi_win/).
- **Keep drives cool and still** — heat and knocks shorten their life.

Ready to turn a drawer drive into an automatic backup? [Get Lomorage](/#download).
