+++
title = "FAQ"
description = "Frequently asked questions"
keywords = ["FAQ","How do I","questions","what if"]
+++

* [1. How comes the name "Lomorage"?](#1-how-comes-the-name-lomorage)
* [2. Why another photo backup service?](#2-why-another-photo-backup-service)
* [3. How to setup redandency backup?](#3-how-to-setup-redundency-backup)
* [4. What file systems supported?](#4-what-file-systems-supported)
* [5. Why the date time seems not correct?](#5-why-the-date-time-seems-not-correct)

## 1. How comes the name "Lomorage"?

If you know what Lomography is, then "Lomorage" is just a combination of "Lomography" and "Storage".

## 2. Why another photo backup service?

We prefer to keep the photos and videos in our own storage rather than uploading them to the cloud, and we'd also like to share them with our family and friends. NAS is a little bit heavyweight for this purpose, it's expensive, hard to install and maintain for non-technical users, and require formatting of hard drive and install system on it.

Buy a cheap Raspberry Pi with only 35$, install the prebuild Lomorage image, connect your own hard drive, download the app, we just need a simple and efficient solution for photo and video backup, management and share.

See more [here](/lomorage.pdf)

## 3. How to setup redundancy backup?

If you are running Lomorage service on macOS (Windows haven't support yet), you can open the settings window of LomoAgent application, and set the redundancy backup there.

If you are running Lomorage service on Raspberry Pi, you can plugin in a new disk drive, and open iOS client APP, go to settings tab and set the redundancy backup there.

## 4. What file systems supported?

If you are on Windows or macOS, then you can use whatever file system supported by Windows or macOS.

If you are on Raspberry Pi, it supports "vfat exfat ext2 ext3 ext4 hfsplus ntfs fuseblk".

## 5. Why the date time seems not correct?

The date time used to store on the system is in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time), not the time of local timezone, the reason is that the photo can be taken in different timezones, and the user may travel or relocate to different timezones, to simplify the processing, we use UTC timestamp, and it can easily convert to different timezones on the APP.

---

> In case you haven't found the answer to your question please feel free to [contact us](/contact), we will be happy to help you.

