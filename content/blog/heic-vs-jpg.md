+++
title = "HEIC vs JPG: Which Format Should You Keep for Your Photo Backup?"
description = "HEIC or JPG for iPhone photos? Compare file size, quality and compatibility, learn when converting makes sense, and why backups should keep the original file."
tags = ["HEIC", "JPEG", "iPhone", "photo backup"]
categories = ["Guides"]
date = "2026-11-25"
banner = "/img/blog/image-quality/320_perc.png"
related = ["piq-size", "backup-live-photos", "backup-iphone-photos-without-icloud"]

[[faq]]
q = "Is HEIC better quality than JPG?"
a = "At the same file size, HEIC generally keeps more detail than JPG, and it supports features like 10-bit color and Live Photos. At the same visual quality, HEIC files are typically much smaller."

[[faq]]
q = "Should I convert HEIC to JPG before backing up?"
a = "No. Converting re-compresses the image and can drop information such as depth data or Live Photo pairing. Back up the original and create JPG copies only when you need to share with a device that can't open HEIC."

[[faq]]
q = "Can Windows open HEIC files?"
a = "Recent versions of Windows can open HEIC with the HEIF Image Extensions from the Microsoft Store. Many photo apps, including Lomorage, can display HEIC photos."
+++

Since iOS 11, iPhones save photos as **HEIC** by default. It saves space, but the moment you try to open one on an older PC or upload it to a website, you may wish everything were still **JPG**. Which should you keep in your backup? Short answer: **the original — whatever it is.** Here's why.

<!--more-->

## HEIC vs JPG at a glance

| | HEIC | JPG |
| --- | --- | --- |
| Typical file size at similar quality | Much smaller | Larger |
| Color depth | Up to 10-bit | 8-bit |
| Live Photos, depth data, bursts | Supported | No |
| Compatibility | Apple devices, recent Windows/Android, many apps | Practically everywhere |

HEIC uses a more modern compression method, so it keeps more detail at the same size. JPG's strength is that everything can open it.

## Why converting is a bad idea for backups

- **Every conversion re-compresses.** JPG is lossy; converting a HEIC adds another round of loss.
- **Extra information can be dropped.** Depth data used for Portrait mode edits, and the pairing that makes a Live Photo move, don't survive a simple JPG conversion.
- **You lose the "source of truth."** If a better format or tool comes along, you want the original, not a copy of a copy.

We've measured how much format choice matters for small thumbnails in our [JPEG vs WebP comparison](/blog/2021/09/01/piq-size/) — the same principle applies: pick formats for *display*, keep originals for *archive*.

## When JPG copies make sense

- Sending photos to a relative whose old computer can't open HEIC.
- Uploading to a website that rejects HEIC.
- Printing services that ask for JPG.

In those cases, export a JPG copy for that purpose and leave the original untouched.

## Should you switch your iPhone to "Most Compatible"?

Settings → Camera → Formats → **Most Compatible** makes the iPhone shoot JPG (and H.264 video). Files will be larger, so your phone and backups fill faster. Most people are better off staying on **High Efficiency** and using a backup that keeps originals.

## Keep originals in your backup

[Lomorage](/) backs up original photos and videos — HEIC, JPG, PNG, RAW/DNG, MP4 and iPhone Live Photos — as ordinary files on your own drive, organized into folders by date. The apps display them on iPhone, Android and the web, so you rarely need to convert anything.

Ready to keep your originals at home? [Get started](/#download), or read [how to back up Live Photos without losing the motion](/blog/2026/11/25/backup-live-photos/).
