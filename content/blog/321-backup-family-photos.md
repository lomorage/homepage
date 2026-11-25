+++
title = "The 3-2-1 Backup Rule for Family Photos, Made Simple"
description = "What is the 3-2-1 backup rule and how do you apply it to family photos? A practical, low-cost setup with a home copy, a second drive and an off-site copy."
tags = ["3-2-1 backup", "photo backup", "redundancy", "external hard drive"]
categories = ["Guides"]
date = "2026-11-24"
banner = "/img/home/mountains.jpg"
related = ["raspberrypi-hd", "set_wd_as_backup", "backup-phone-photos-to-nas"]

[[faq]]
q = "What is the 3-2-1 backup rule?"
a = "Keep 3 copies of your data, on 2 different storage devices, with 1 copy off-site. For photos that usually means the originals on your phone or main drive, a second local drive, and one copy kept somewhere else."

[[faq]]
q = "Is RAID or a mirrored NAS the same as a backup?"
a = "No. RAID protects against a single drive failing, but an accidental deletion, ransomware or a power surge affects every mirrored drive at once. You still need a separate copy."

[[faq]]
q = "How often should I check my photo backups?"
a = "A quick check every few months is a good habit: open a few recent and old photos and videos from each copy to confirm they still open correctly."
+++

Every photo backup guide eventually mentions the **3-2-1 rule**. It sounds technical, but it's really just common sense written as numbers. Here's what it means for a family photo library, and a simple, affordable way to get there.

<!--more-->

## The rule in one sentence

**Keep 3 copies of your photos, on 2 different devices, with 1 copy away from home.**

- **3 copies:** the original plus two backups. Any single copy can fail.
- **2 different devices:** for example, a computer's drive and a separate external drive. If both copies sit on the same disk, one failure takes both.
- **1 off-site:** a fire, flood or burglary can destroy everything in one house. One copy somewhere else protects against that.

## Why phones and one cloud account aren't enough

A phone gets lost, dropped or upgraded. A single cloud account can be locked, hit a storage cap, or have photos deleted by sync mistakes — deleting on one device often deletes everywhere. Sync is not the same as backup.

## What can go wrong (and which copy saves you)

| Problem | Protected by |
| --- | --- |
| Phone lost or broken | Any backup |
| Main hard drive fails | The second device |
| Accidental deletion that syncs | An independent copy that doesn't mirror deletions instantly |
| Fire, flood, theft | The off-site copy |

## A practical 3-2-1 setup for families

### Copy 1 — Home photo cloud (automatic)

Install [Lomorage](/) on a Windows PC, Mac, NAS or Raspberry Pi. Phones back up originals over Wi-Fi automatically, and files are stored as ordinary files on your drive. This is the copy you'll browse and search every day.

### Copy 2 — A second drive at home

Add a separate external drive as a redundancy (secondary) backup. We have step-by-step guides for doing this with a [Raspberry Pi and a second drive](/blog/2019/12/24/raspberrypi-hd/) and for using a [WD MyCloud as a backup disk on Windows](/blog/2023/02/22/set_wd_as_backup/). On macOS, redundancy backup can be set in the LomoAgent settings ([FAQ](/faq/#how-to-setup-redundancy-backup)).

### Copy 3 — Off-site

Options, from simplest to most automated:

- **Rotate a drive:** every month or season, copy the photo folder to an external drive and keep it at a relative's home or your office.
- **A cloud service for the essentials:** if a subscription is worth it to you, use it as the off-site copy rather than the only copy.
- **A second Lomorage location:** some families keep a small server at a relative's home.

## Keep it working

- **Test restores.** Every few months, open a few old and new photos and videos from each copy.
- **Watch drive age.** Hard drives commonly last several years; plan to replace them before they fail. Our [migration guide](/blog/2023/03/02/migrate_from_pi_win/) shows how to move to a bigger drive.
- **Don't confuse RAID with backup.** Mirrored drives protect against one disk dying, not against deletion or disasters.

## Cost

You don't need expensive gear. A computer you already own, two external drives, and the free Lomorage desktop app cover the first two copies. See our [cost comparison](/compare/) for how a home setup compares with yearly cloud fees.

Start with copy one today: [set up Lomorage](/#download), then add a second drive this weekend.
