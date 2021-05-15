Table of Contents
=================

   * [Lomorage - Save the moments, enjoy the memories](#lomorage---save-the-moments-enjoy-the-memories)
      * [Problem to solve](#problem-to-solve)
      * [Solution](#solution)
      * [Features](#features)
      * [Installation](#installation)
      * [FAQ](#faq)
      * [Repositories](#repositories)
         * [Homepage](#homepage)
         * [Lomod](#lomod)
         * [LomoAgentWin](#lomoagentwin)
         * [LomoAgentOSX](#lomoagentosx)
         * [lomoUpdate](#lomoupdate)
         * [lomo-docker](#lomo-docker)
         * [lomo-android-apk-release](#lomo-android-apk-release)
         * [lomo-android-frame-apk-release](#lomo-android-frame-apk-release)
         * [lomo-web](#lomo-web)
         * [pi-gen](#pi-gen)
         * [pi_video_looper](#pi_video_looper)

# Lomorage - Save the moments, enjoy the memories

*This is the homepage source of [Lomorage](https://lomorage.com), check bottom for reference to other repos*

*Lomorage is still on going project, however the basic features are pretty solid and ready to use*

## Problem to solve

- Worry about privacy leaking on cloud.

- Family photos and videos hard to organize locally.

- Large volume of HD videos uploading to cloud, slow and expensive.

- Network Attached Storage is complex for non-technical users and costly for consumer.

- Memories are fading out and buried in hard drives.

- No easy ways to move photos to digital photo frames with limited storage.

- No in-home digital signage to display family photos, calendar, events and more.

## Solution

Lomorage Box hosted at home to “save the moments”, Lomorage Frame and Signage placed in different places to “enjoy the memories”.

- No Privacy Concerns, avoid Leaking.

- Same Cloud Experience, a Private Cloud.

- More Storage, at Lower Cost.

- Faster Access, data Closer To User.

- No buried Memories, AI digital frames.

Check the product vision [here](https://lomorage.com/lomorage.pdf)

## Features

- Backup photo on smart phone.
- Incremental backup, fast and reliable.
- Resumable backup, you can upload large video more reliably.
- Support live photo, slow motion, raw DNG format and other popular media formats.
- Save original file, no quality degradation, no metadata lost.
- Photo/Video deduplicate。
- Similarity check, you can choose to save the best one with multiple shoots。
- Access photos seamlessly on multiple device with one account.
- Isolated accounts for family members, keep your privacy.
- Save secrets with encryption. (coming soon)
- Sharing tons of photos without worry about phone storage.
- No need to save photo locally to share in social network.
- Easy access when you switching phone with different OS.
- Export backup to Phone。
- Offline mode so you can browser photos even without connectivity.
- Search by location, date time, text in photo.
- History of today, never buries the memories in hard drive.
- Tagging and create album. (coming soon)
- Redundancy backup, lower the risk of losing data.
- Import photo from hard drive, SD card etc.
- No rate limit, no account number limitation, no vendor lock in.
- Hard drive plug and play, no reformat required.

## Installation

Check the [installation](https://lomorage.com/installation/) guide.

[![Watch the video](https://img.youtube.com/vi/VcSPcR6MB-4/hqdefault.jpg)](https://youtu.be/VcSPcR6MB-4)

## FAQ

Check FAQ [here](https://lomorage.com/faq/)

If you have any issues, questions, concerns:

- submit Github [issue](https://github.com/lomorage/homepage/issues/new)

- join slack [channel](https://app.slack.com/client/THK8CPS4X/CHK8CQ4H5)

- [Google Group](https://groups.google.com/u/0/g/lomorage)

- [contact form](https://lomorage.com/contact/)

- [email us](mailto:support@lomorage.com)

## Repositories

### Homepage

The text content is in https://github.com/lomorage/homepage/tree/master/content

To run homepage locally
~~~ 
cd /homepage
hugo server
~~~

### Lomod

https://github.com/lomorage/lomod

Lomod is the Lomorage backend service. This repo includes armhf and amd64 binaries release of lomod(lomo-backend) in Linux.

### LomoAgentWin

https://github.com/lomorage/LomoAgentWin

LomoAgentWin is the Lomorage backend application running on Windows. This repo contains the [binaries](https://github.com/lomorage/LomoAgentWin/releases) of the release.

### LomoAgentOSX

https://github.com/lomorage/LomoAgentOSX

LomoAgentOSX is the Lomorage backend application running on OSX. This repo contains the [binaries](https://github.com/lomorage/LomoAgentOSX/releases) of the release as well as the source code.

### lomoUpdate

https://github.com/lomorage/lomoUpdate

This is used for autoupdate of LomoAgentWin and LomoAgentOSX so once we release new version, it will update automatically.

### lomo-docker

https://github.com/lomorage/lomo-docker

You can use the docker image to install Lomorage on your existing Raspberry Pi setup, or you can run it on Windows/Mac.

### lomo-android-apk-release

https://github.com/lomorage/lomo-android-apk-release

You can download the [apk release](https://github.com/lomorage/lomo-android-apk-release) of Lomorage Android Application.

### lomo-android-frame-apk-release

https://github.com/lomorage/lomo-android-frame-apk-release

Lomorage frame app for FireTV, android Tablet.

### lomo-web

https://github.com/lomorage/lomo-web

Lomorage Web Application.

### pi-gen

https://github.com/lomorage/pi-gen/tree/lomorage

Tool used to create customized Lomorage Raspbian image, which provides easy way to setup.

### Armbian image builder

https://github.com/lomorage/build

Tool used to create customized Lomorage Armbian image.

### pi_video_looper

https://github.com/lomorage/pi_video_looper

Source code of lomo-frame, which can be installed on Raspberry Pi, so you can connect with HDMI monitor to make your own digital frame.
