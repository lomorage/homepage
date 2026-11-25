+++
title = "Build a Low-Power Raspberry Pi Photo Backup Server for Your Family"
description = "Turn a Raspberry Pi and a USB hard drive into an always-on family photo backup server with Lomorage: what to buy, how to install, and tips for reliability."
tags = ["Raspberry Pi", "photo backup", "self-hosted", "Lomorage"]
categories = ["Guides"]
date = "2026-11-25"
banner = "/img/blog/raspberrypi-hd/power-hub-adafruit.jpg"
related = ["raspberrypi-hd", "321-backup-family-photos", "external-hard-drive-photo-backup"]

[[faq]]
q = "Is a Raspberry Pi powerful enough for photo backup?"
a = "Yes for backup and browsing. Lomorage has been tested on Raspberry Pi 4 Model B, 3 Model B+, Zero W and 2 Model B; newer models give better performance. AI search in LomoMobile can run on your phone, so the Pi doesn't need to do the heavy lifting."

[[faq]]
q = "What do I need to build a Raspberry Pi photo server?"
a = "A Raspberry Pi board, a reliable power supply, a 16 GB or larger microSD card, a USB hard drive, and ideally a powered USB hub and an Ethernet cable."

[[faq]]
q = "What happens to my photos if the microSD card fails?"
a = "Your photos are stored on the hard drive, and the database is backed up to the hard drive as well. You can reinstall the image and restore the database, as described in the Lomorage FAQ."
+++

A Raspberry Pi sips a few watts, stays on all year, and costs less than a year of many cloud photo plans. Add a USB hard drive and you have an **always-on photo backup server** that every phone in the house can use. Here's how to build one with Lomorage.

<!--more-->

## Why a Raspberry Pi

- **Always on, low power.** Phones can back up at night without a PC running.
- **Cheap.** A board, power supply, microSD card and a hard drive you may already own.
- **Quiet and small.** It can sit next to your router.
- **Your files, your drive.** Photos are stored as ordinary files in folders by date.

## Shopping list

- **Raspberry Pi** — tested models include Pi 4 Model B, 3 Model B+, Zero W and 2 Model B. Newer is faster.
- **Official or quality power supply.** Under-powering causes strange problems.
- **16 GB+ microSD card.**
- **USB hard drive** with room to grow.
- **Powered USB hub** — strongly recommended for 2.5" drives or more than one drive.
- **Ethernet cable** — faster and more reliable than Wi-Fi.

## Install in four steps

1. **Download the prebuilt Lomorage image** linked in the [Raspberry Pi guide](/docs/Installation/lomorage-service/installation-raspbian/).
2. **Flash it** to the microSD card with balenaEtcher.
3. **Connect** the hard drive, Ethernet and power, then wait a few minutes for the first boot.
4. **Install LomoMobile** on your phone, create your account and start backing up.

Prefer to keep your existing Raspberry Pi OS? The guide also covers **Docker** and **apt** installation. Using a different board? See [Armbian](/docs/Installation/lomorage-service/installation-armbian/).

## Make it reliable

- **Use a powered hub** for drives — power issues are the most common cause of disconnects.
- **Add a second drive** as a redundancy backup. Step-by-step: [Set up a secondary backup with Raspberry Pi](/blog/2019/12/24/raspberrypi-hd/).
- **Know your recovery path.** If the microSD card fails, your photos are still on the hard drive and the database is backed up there too — see [how to recover from a boot failure](/faq/#how-to-recover-from-raspbian-boot-failure).
- **Outgrowing the Pi?** Move the library to a Windows server and a bigger drive with our [migration guide](/blog/2023/03/02/migrate_from_pi_win/).

## Bonus: a photo frame

The prebuilt image includes the Lomorage digital frame application. Plug in an HDMI screen and the Pi can show your family photos — or use an [old Android tablet as a frame](/blog/2021/08/26/zero-cost-android-frame/).

## Remote access

To view originals away from home, set up a tunnel or router port mapping: [External access](/docs/Usage/external-access/).

A Pi server is a great first copy. Keep a second and an off-site copy too — [the 3-2-1 rule](/blog/2026/11/24/321-backup-family-photos/) explains why.
