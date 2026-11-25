+++
title = "Back Up Phone Photos to a Synology NAS, Unraid or Docker Server"
description = "Automatically back up iPhone and Android photos to your Synology NAS, Unraid or any Docker host with Lomorage: setup steps, folder layout and tips."
tags = ["NAS", "Synology", "Docker", "Unraid", "photo backup"]
categories = ["Guides"]
date = "2026-11-24"
banner = "/img/home/mountains.jpg"
related = ["google-photos-alternative", "321-backup-family-photos", "windows-docker"]

[[faq]]
q = "Can I back up my iPhone to a Synology NAS without Synology Photos?"
a = "Yes. Lomorage runs as a Docker container on Synology, and the LomoMobile app backs up iPhone and Android photos to it over your home network."

[[faq]]
q = "Where are the photos stored on the NAS?"
a = "In the folder you mount as the container's /media directory. Photos are stored as ordinary files, so they remain accessible with normal NAS tools."

[[faq]]
q = "Does a NAS replace the need for another backup?"
a = "No. A NAS, even with RAID, is one device in one location. Keep another independent copy of irreplaceable photos, ideally off-site."
+++

A NAS is already on 24/7, has plenty of space, and sits on your home network — the perfect place for your family's photo backups. This guide shows how to run Lomorage on a **Synology NAS, Unraid, or any Docker host**, so every phone in the house backs up automatically.

<!--more-->

## Why put your photo backup on a NAS

- **Always on.** Phones can back up at night without leaving a computer running.
- **Room to grow.** Add or upgrade drives as the library grows.
- **Shared by the family.** Each person gets their own account; everyone backs up to the same place.
- **Ordinary files.** Photos stay as regular files in a folder you choose, not locked inside an app database.

## What you need

- A Synology NAS with Container Manager (Docker), an Unraid server, or any Linux machine with Docker (amd64 or arm).
- iPhones or Android phones with the LomoMobile app.
- Phones and NAS on the same home network for setup.

## Synology: the short version

1. In **Container Manager / Docker**, search the registry for `lomorage` and download the image matching your NAS architecture (arm or amd64).
2. Launch the container and enable **auto-restart**.
3. Create a `docker/lomorage` folder with two subfolders:
   - `data` → mount to `/media` (your photos and videos)
   - `app` → mount to `/lomo` (configuration and logs)
4. Map TCP port `8000 → 8000` and click **Apply** to start the container.
5. On your phone, install LomoMobile, connect to the home Wi-Fi, and add the server. With the default bridge network you enter the NAS's IP address; setting up a macvlan network lets the app discover the server automatically.

The full walkthrough with screenshots is in the [Synology installation guide](/docs/Installation/lomorage-service/installation-synology/).

## Unraid and plain Docker

- **Unraid:** follow the [Unraid guide](/docs/Installation/lomorage-service/installation-unraid/).
- **Docker on Linux, Windows or another NAS:** see the [Docker guide](/docs/Installation/lomorage-service/installation-docker/). For Windows specifically, we also have a [Docker on Windows walkthrough](/blog/2020/11/16/windows-docker/).

Other platforms, including Raspberry Pi, Ubuntu and OpenWrt, are listed on [Choose a computer or home server](/docs/Installation/lomorage-service/).

## Phone-side tips

- **First backup:** keep LomoMobile open and the phone charging. Mobile systems limit background activity, especially on iPhone.
- **Schedules:** after the first sync, choose Wi-Fi-only, charging-only or nighttime backups.
- **Select folders:** on Android, choose which folders to include (camera, screenshots, messaging apps).
- **Family members:** create an account for each person and let them scan a sign-in code.

## Bring in existing photos

If you already have years of photos on the NAS or an old drive, import them with the [Lomorage importer](/docs/Installation/lomorage-importer/) so everything is searchable in one place. Moving from WD MyCloud? See [Move MyCloud to Lomorage](/blog/2020/05/17/import_my_cloud/).

## Access away from home

Viewing originals outside your home network requires either a tunnel service or router port mapping. See [External access](/docs/Usage/external-access/), or our guide to [running a tunnel on fly.io](/blog/2022/10/14/flyio/).

## RAID is not a backup

Mirrored drives protect you from one disk failing, but not from accidental deletion, ransomware or disasters. Pair your NAS with a second copy elsewhere — see [the 3-2-1 rule for family photos](/blog/2026/11/24/321-backup-family-photos/).

Ready? [Get the LomoMobile app](/#download) and point it at your NAS.
