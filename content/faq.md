+++
title = "FAQ"
description = "Frequently asked questions"
keywords = ["FAQ","How do I","questions","what if"]
+++

* [1. How comes the name "Lomorage"?](#1-how-comes-the-name-lomorage)
* [2. What is the cost of Lomorage?](#2-what-is-the-cost-of-lomorage)
* [3. What is the business model?](#3-what-is-the-business-model)
* [4. How to setup redundancy backup?](#4-how-to-setup-redundancy-backup)
* [5. What file systems supported?](#5-what-file-systems-supported)
* [6. Why the date time seems not correct?](#6-why-the-date-time-seems-not-correct)
* [7. How to set a secondary backup?](#7-how-to-set-a-secondary-backup)
* [8. Does Lomorage support backup edited file?](#8-does-lomorage-support-backup-edited-file)
* [9. What is background backup?](#9-what-is-background-backup)
* [10. How to recover from Raspbian boot failure?](#10-how-to-recover-from-raspbian-boot-failure)
* [11. I forget password, how to reset?](#11-i-forget-password-how-to-reset)

## 1. How comes the name "Lomorage"?

If you know what Lomography is, then "Lomorage" is just a combination of "Lomography" and "Storage".

## 2. What is the cost of Lomorage?

Software is free, and user can buy hardware according to their needs, you can use Orange Pi Zero which will cost you less than $20. Check [here](/compare) for more details on cost for different configurations.

## 3. What is the business model?

This is a side project starts with 3 fathers seeking a better solution for the digital assets for the family and we are doing that in spare time, we have been doing this for two years. We started this with love and build it with love, and we use it in our daily life, we do spend a lot of time on that, but we know we probably will do this even nobody is paying us, because that is what we need, and the way we do this doesn’t cost us much, the only thing we paid for now it’s the apple developer account and a domain name, we don’t host the storage, we don’t offer the device, we host website and software download at github for free, so the answer why it’s free it’s because we can.

Nothing is free, and need to make money to make it sustainable, we wish we can do that full time to get the features delivered faster, but we just can't at this stage. We will be happy if people find the product useful and willing to spend money on that, for now the product is at early stage with basic features like backup and share, and we provide that as freeware. We don’t have to make user part of the products, and we care the privacy since day one because we are ourself the user. 

Peter Thiel said: "To build a successful startup, you have to be **10 times better** than second best.”, and we also believe: to make money out of something, we need to build something that is valuable first.

We are planning to release more advanced features (like advanced search, remote backup, digital frame etc), and will probably think about monetize some of them. And the digital photo frame as a dominate screen in the room, there can be multiple ones, for example, a big screen in living room and some smaller ones put on desks in bedroom or study room, there is also possibilities to monetize.

## 4. How to setup redundancy backup?

If you are running Lomorage service on macOS (Windows haven't support yet), you can open the settings window of LomoAgent application, and set the redundancy backup there.

If you are running Lomorage service on Raspberry Pi, you can plugin in a new disk drive, and open iOS client APP, go to settings tab and set the redundancy backup there.

## 5. What file systems supported?

If you are on Windows or macOS, then you can use whatever file system supported by Windows or macOS.

If you are on Raspberry Pi, it supports "vfat exfat ext2 ext3 ext4 hfsplus ntfs fuseblk".

## 6. Why the date time seems not correct?

The date time used to store on the system is in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time), not the time of local timezone, the reason is that the photo can be taken in different timezones, and the user may travel or relocate to different timezones, to simplify the processing, we use UTC timestamp, and it can easily convert to different timezones on the APP.

## 7. How to set a secondary backup?

There are several options to setup a secondary backup, check this [blog](/blog/2019/12/24/raspberrypi-hd/) for more details.

## 8. Does Lomorage support backup edited file?

On iOS, if photo is edited, system will store the original photo, the edited one, as well as the editing operations, **Lomorage will store ONLY the edited photo**. For edited video, system will store the video before last editing, the editing operations as well as the edited one, and **Lomorage will ONLY store the edited video**.

If you would like to store the file before editing, make sure you have backup the edited one first, and then you can revert the editing in Apple's "Photos APP", and then upload those files before editing.

Notice: The old iOS client (<0.6.10) doesn't support edited files, so if you have error when uploading the edited files, please delete old client and reinstall the new one, instead of upgrading to new version, to make sure the old problematic database is removed.

## 9. What is background backup?

Background backup means you don't need to open Lomorage app to backup the assets. 

Background backup on iOS is not expected to work the same way as iCloud, Apple restricts 3rd party tools to run in the background. Currently there is only two hacks to trigger Lomorage running in the background, one is background fetch, which might be triggered when system is idle, another one is triggered when significant location changes, that is why background backup requires location permission. Both won't last long and can only run in background for a limited time.

Moving Lomorage app into background, the existing upload is still running in the background but the next upload has to wait either it's back to foreground or the above two hack condition triggers the upload.

## 10. How to recover from Raspbian boot failure?

Don't worry, your Photo are stored on hard drive, and the database is backup to hard drive as well. You just need to recovery the backup database.

1. plugin in your hard drive to PC, and you can find that assets.db in each user's Lomorage home directory, they are exactly the same.
2. reinstall Lomorage Raspbian image.
3. attach hard drive to Raspberry Pi.
4. copy assets.db from one user's Lomorage home directory on hard drive to `/opt/lomorage/var/` on Raspberry Pi.
5. restart Lomorage service on Raspberry Pi: `sudo service lomod restart`.

This applies to Armbian as well.

## 11. I forget password, how to reset?

Don't worry, you can alway reset password by running `/opt/lomorage/bin/lomoc user reset [user name] [password]` at Lomorage box. `username` is username reset for, and `password` is new password you like to use

---

> In case you haven't found the answer to your question please feel free to [contact us](/contact), we will be happy to help you.
