+++
title = "How to Back Up iPhone Photos to a Windows PC Without iCloud"
tags = ["iPhone", "Windows", "iCloud", "backup"]
categories = ["BLOG"]
date = "2026-11-24T11:00:00-08:00"
+++

Your iPhone says storage is full. Apple offers you more iCloud storage, every month, forever. There is another option: back your photos up to a Windows PC you already own, keep the originals at home, and delete the copies from your phone only once you have confirmed they are safe.

That is what Lomorage does. The desktop app is free, the phone app is a one-time $1.99 purchase, and there is no subscription.

<!--more-->

## What iCloud costs over time

iCloud gives you 5 GB free, which fills up fast once you shoot photos and videos. The paid iCloud+ tiers in the US, verified November 24, 2026, are:

| Plan | Per month | Per year | Over 5 years |
| --- | --- | --- | --- |
| iCloud+ 50 GB | $0.99 | $11.88 | $59.40 |
| iCloud+ 200 GB | $2.99 | $35.88 | $179.40 |
| iCloud+ 2 TB | $9.99 | $119.88 | $599.40 |

With Lomorage, the phone app costs $1.99 once and the desktop app is free. Your photos live on your own computer's disk, so the only other cost is disk space you may already have. The trade-off is honest: your computer has to be on and reachable while a backup runs, and a home disk is not a guarantee against loss, so keep a second copy of the photos you could never replace.

## What you need

- A Windows PC (x64) with enough free disk space
- An iPhone with iOS 15.1 or later
- Both devices on the same home Wi-Fi network
- Your computer switched on during the backup

## Step 1: Install Lomorage on your Windows PC

On your PC, press Win + R, type `cmd`, and press Enter. Copy the command below, paste it, and press Enter. You do not need an administrator password.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm 'https://lomorage.com/windows/install.ps1' -OutFile "$env:TEMP\lomorage-install.ps1"; & "$env:TEMP\lomorage-install.ps1""
```

Wait for the setup page to open in your browser. For a first setup, it shows a QR code. Keep it on screen.

## Step 2: Install the phone app and scan the code

Install [Lomorage: Free Up Photo Space](https://apps.apple.com/us/app/lomomobile/id6771038226?ct=blog-iphone-windows) on your iPhone, join the same home Wi-Fi network, and use the scanner inside the app to scan the setup code on your computer. Then create an account and choose where to store your photos. The app recommends the drive with the most free space.

## Step 3: Allow photo access and run the first backup

Allow access to the photos you want to back up. Choose "Allow Access to All Photos" so the backup is actually complete: if you only allow selected photos, only those photos get backed up.

Keep the app open for the first backup, especially if you have years of photos. When it finishes, open a few photos and videos and check they open correctly at full quality, including Live Photos.

## Step 4: Free up space, only after you have checked

Once you have confirmed the backup is complete and the originals open correctly, use Free Up Space in the app. It lists the large videos and photos that are already backed up, so you know exactly what you can delete from your phone without losing anything. Nothing is deleted unless you choose to delete it.

## A few honest limits

- Your computer needs to be on and reachable while backing up, and to view the originals stored on it. What the app has cached on your phone is available offline; do not assume every original is.
- Confirm the backup before you delete anything from your phone.
- Local storage can fail like any disk. Copy your most important photos to a separate drive as well.
- Your family can join too: each person creates a separate account and scans a code to connect to the same computer.

## Get started

- iPhone: [Lomorage: Free Up Photo Space on the App Store](https://apps.apple.com/us/app/lomomobile/id6771038226?ct=blog-iphone-windows) — $1.99 once, no subscription
- Android: [Lomorage: Free Up Photo Space on Google Play](https://play.google.com/store/apps/details?id=com.wtao.lomo&utm_source=blog&utm_medium=article&utm_campaign=iphone-windows) — $1.99 once, no subscription
- Desktop app for Windows and Mac: free, from [lomorage.com](https://lomorage.com/)
