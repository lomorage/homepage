+++
title = "Set Up Photo Backup for Your Parents (So They Never Have to Think About It)"
description = "Help parents and grandparents back up their phone photos automatically: a simple family setup with separate accounts, sign-in by QR code, and no monthly fees."
tags = ["family", "photo backup", "parents", "Lomorage"]
categories = ["Guides"]
date = "2026-11-25"
banner = "/img/home/family.jpg"
related = ["backup-iphone-photos-without-icloud", "switch-phones-keep-photos", "321-backup-family-photos"]

[[faq]]
q = "What's the easiest photo backup for elderly parents?"
a = "One that runs automatically after a one-time setup. With Lomorage, you set up storage once, create an account for each parent, and they sign in to the phone app by scanning a code. After that, backup runs on a schedule."

[[faq]]
q = "Do my parents need to live with me?"
a = "Setup and sign-in happen on the home network where the server runs. For backups from another home, you can run a separate Lomorage server there, or configure external access; see the external access guide."

[[faq]]
q = "Can each family member keep their own photos separate?"
a = "Yes. Each person has their own account, so their photos are kept in their own library."
+++

Your parents' phones hold irreplaceable photos — grandchildren, old friends, trips they waited years to take. They're also the least likely to manage a backup themselves. Here's how to set things up once so their photos are protected **without them having to do anything**.

<!--more-->

## What makes a backup "parent-proof"

- **No passwords to remember** day to day.
- **No monthly bill** to cancel by accident or forget to renew.
- **Automatic** — it runs without anyone opening a menu.
- **Someone (you) can check** that it's working.

## A simple family setup with Lomorage

[Lomorage](/) stores everyone's photos on one computer or NAS at home, with a separate account for each person.

### Once, on your side

1. Install the free desktop app on a Windows PC or Mac, or run it on a NAS or [Raspberry Pi](/blog/2026/11/25/raspberry-pi-photo-server/).
2. Create an account for yourself in LomoMobile.
3. Create **separate accounts** for each parent.

### On your parents' phones (10 minutes)

1. Install **LomoMobile** (iPhone or Android).
2. Connect to the home Wi-Fi.
3. **Scan the sign-in code** prepared for their account — no typing.
4. Allow photo access and turn on automatic backup. **Charging-only** or **nighttime** is perfect: phones back up while they sleep.
5. Keep the app open for the first backup and let it finish.

## Things to explain (briefly)

- "Leave the phone charging overnight on Wi-Fi — that's when it backs up."
- "If the phone says storage is full, call me before deleting anything."
- Show them how to find photos by person or place — grandparents love searching for grandchildren. ([AI search guide](/blog/2026/11/25/find-old-photos-ai-search/))

## Your monthly 2-minute check

- Open their library in the app and confirm recent photos are there.
- If the phone is getting full, use **Free Up Space** together — it removes large files already backed up ([guide](/blog/2026/11/24/free-up-phone-storage/)).

## If your parents live elsewhere

The simplest option is to set up a small Lomorage server in their home — a Raspberry Pi with a hard drive is enough. Alternatively, set up [external access](/docs/Usage/external-access/) to your home server (this requires some technical setup).

## Protect the whole family's library

All your family's memories in one place deserve more than one copy. Add a second drive and an off-site copy — [the 3-2-1 rule](/blog/2026/11/24/321-backup-family-photos/) shows how.

The desktop app is free; each phone needs LomoMobile, a $1.99 one-time purchase. [Set up your family](/#download).
