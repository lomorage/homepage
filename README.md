Table of Contents
=================

   * [Lomorage - Save the moments, enjoy the memories](#lomorage---save-the-moments-enjoy-the-memories)
      * [Feature highlights](#feature-highlights)
      * [Installation](#installation)
      * [FAQ](#faq)
      * [Source code](#source-code)
      * [Repositories](#repositories)

# Lomorage - Save the moments, enjoy the memories

*This is the source of the [Lomorage](https://lomorage.com) homepage and documentation. See [Repositories](#repositories) for the other Lomorage projects.*

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

Follow the [installation guide](https://lomorage.com/#download):

1. On the Windows or Mac computer that will store your photos, run the one-line install command shown on the page. NAS, Raspberry Pi, Linux and Docker guides are in the [documentation](https://lomorage.com/docs/Installation/lomorage-service/).
2. Install **LomoMobile** from the [App Store](https://apps.apple.com/app/lomomobile/id6771038226) or [Google Play](https://play.google.com/store/apps/details?id=com.wtao.lomo), then scan the setup QR code shown on your computer.

Full documentation: https://lomorage.com/docs/

## FAQ

Check FAQ [here](https://lomorage.com/faq/)

If you have any issues, questions, concerns:

- submit Github [issue](https://github.com/lomorage/homepage/issues/new)

- [contact form](https://lomorage.com/contact/)

- [email us](mailto:support@lomorage.com)

## Source code

Both the mobile app and the server are open source under the MIT License:

- **Mobile app:** [lomorage/lomo-mobile](https://github.com/lomorage/lomo-mobile), the LomoMobile app for iOS and Android.
- **Server:** [lomorage/lomod](https://github.com/lomorage/lomod), the service that stores your photos on your own computer, NAS or Raspberry Pi.

Lomorage runs on your own hardware: your photos stay on your disks, there is no tracking, and anything we might collect (crash logs, discovery, etc.) is opt-in only. With the source open, you can verify this yourself.

## Repositories

### lomo-mobile

https://github.com/lomorage/lomo-mobile

Source code of LomoMobile, the Lomorage mobile app for iOS and Android (React Native / Expo).

### Lomod

https://github.com/lomorage/lomod

Source code of lomod, the Lomorage server: a self-hosted photo and video backup service for Linux, Raspberry Pi, Windows and macOS.

### lomo-docker

https://github.com/lomorage/lomo-docker

You can use the docker image to install Lomorage on your existing Raspberry Pi setup, or you can run it on Windows/Mac.

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
