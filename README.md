Table of Contents
=================

   * [Lomorage - Save the moments, enjoy the memories](#lomorage---save-the-moments-enjoy-the-memories)
      * [Features Highlights](#feature-highlights)
      * [Installation](#installation)
      * [FAQ](#faq)
      * [Repositories](#repositories)
         * [Lomod](#lomod)
         * [LomoAgentWin](#lomoagentwin)
         * [LomoAgentOSX](#lomoagentosx)
         * [lomoUpdate](#lomoupdate)
         * [lomo-docker](#lomo-docker)
         * [lomo-android-apk-release](#lomo-android-apk-release)
         * [lomo-android-frame-apk-release](#lomo-android-frame-apk-release)
         * [pi-gen](#pi-gen)
         * [pi_video_looper](#pi_video_looper)

# Lomorage - Save the moments, enjoy the memories

*This is the homepage source of [Lomorage](https://lomorage.com), check bottom for reference to other repos*

*Lomorage is still on going project, however the basic features are pretty solid and ready to use*

**The simplest, easiest to use private photo cloud for the family.**

- Automatic Back Up: Automatically backs up all your photos from smartphones and computers to your own hard drive; Redundancy backup lowers the risk of losing data. No rate limits.

- Original Quality: Whether it’s a 50 megapixel raw photo or hour long 4K HD video, back up your high resolution content as it is without any modification. What you take is what is saved.

- Intelligent Organization: Use AI to sort your photos by date, location, person, scene; search by texts in photos; detect similar photos; remove duplicated assets; history of today reminder.

- Unlimited Accounts: One server for all family members while each member has its own account, no account number limits. Share becomes easy.

- Your Photos, Wherever You Are: Browse ALL your photos and videos from apps on your Android, iOS, Chromecast, Fire TV device, or a web browser; No need to worry about the phone space.

- It’s Your Data: No tracking. We believe in privacy is super important for everyone, and anything we might collect (crash logs, discovery, etc.) is opt-in only. no vendor lock in.

## Feature highlights

- Backup photo on smart phone.
- Incremental backup, fast and reliable.
- Resumable backup, you can upload large video more reliably.
- Support live photo, slow motion, raw DNG format and other popular media formats.
- Save original file, no quality degradation, no metadata lost.
- Photo/Video deduplicate。
- Similarity check, you can choose to save the best one with multiple shoots。
- Access photos seamlessly on multiple device with one account.
- Isolated accounts for family members, keep your privacy.
- Sharing tons of photos without worry about phone storage.
- Easy access when you switching phone with different OS.
- Export backup to Phone。
- Offline mode so you can browser photos even without connectivity.
- Search by location, date time, text in photo.
- History of today, never buries the memories in hard drive.
- Support user album and smart album.
- Redundancy backup, lower the risk of losing data.
- Import photo from hard drive, SD card etc.
- No rate limit, no account number limitation, no vendor lock in.
- Hard drive plug and play, no reformat required.

## Installation

Check the [installation](https://lomosw.lomorage.com/en/index.html) guide.

## FAQ

Check FAQ [here](https://lomorage.com/faq/)

If you have any issues, questions, concerns:

- submit Github [issue](https://github.com/lomorage/homepage/issues/new)

- join slack [channel](https://app.slack.com/client/THK8CPS4X/CHK8CQ4H5)

- [contact form](https://lomorage.com/contact/)

- [email us](mailto:support@lomorage.com)

## Repositories

**The code of mobile client and backend service is closed source.** 

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

### pi-gen

https://github.com/lomorage/pi-gen/tree/lomorage

Tool used to create customized Lomorage Raspbian image, which provides easy way to setup.

### Armbian image builder

https://github.com/lomorage/build

Tool used to create customized Lomorage Armbian image.

### pi_video_looper

https://github.com/lomorage/pi_video_looper

Source code of lomo-frame, which can be installed on Raspberry Pi, so you can connect with HDMI monitor to make your own digital frame.
