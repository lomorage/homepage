+++
title = "FAQ"
description = "Frequently asked questions"
keywords = ["FAQ","How do I","questions","what if"]
+++

* [How comes the name "Lomorage"?](#how-comes-the-name-lomorage)
* [What is the cost of Lomorage?](#what-is-the-cost-of-lomorage)
* [How to setup redundancy backup?](#how-to-setup-redundancy-backup)
* [What file systems supported?](#what-file-systems-supported)
* [Why folders named with date time seem not correct on hard drive?](#why-folders-named-with-date-time-seem-not-correct-on-hard-drive)
* [How to setup a secondary backup?](#how-to-setup-a-secondary-backup)
* [Does Lomorage support backup edited file?](#does-lomorage-support-backup-edited-file)
* [What is background backup?](#what-is-background-backup)
* [How to recover from Raspbian boot failure?](#how-to-recover-from-raspbian-boot-failure)
* [I forget password, how to reset?](#i-forget-password-how-to-reset)
* [What can it do besides photo backup and management?](#what-can-it-do-besides-photo-backup-and-management)
* [What is the size of storage?](#what-is-the-size-of-storage)
* [Can it connected with multiple hard drives?](#can-it-connected-with-multiple-hard-drives)
* [Can I use spare hard drive?](#can-i-use-spare-hard-drive)
* [Does it support hard drive sleep?](#does-it-support-hard-drive-sleep)
* [How to install?](#how-to-install)
* [How to view the backup photos?](#how-to-view-the-backup-photos)
* [Does it support remote access?](#does-it-support-remote-access)
* [Does it support export from backup to Phone?](#does-it-support-export-from-backup-to-phone)
* [Can't upgrade server in Linux?](#cant-upgrade-server-in-linux)

## How comes the name "Lomorage"?

If you know what Lomography is, then "Lomorage" is just a combination of "Lomography" and "Storage".

## What is the cost of Lomorage?

Software is free, and user can buy hardware according to their needs, you can use Orange Pi Zero which will cost you less than $20. Check [here](/compare) for more details on cost for different configurations. **No hidden fees**.

## How to setup redundancy backup?

If you are running Lomorage service on macOS (Windows haven't support yet), you can open the settings window of LomoAgent application, and set the redundancy backup there.

If you are running Lomorage service on Raspberry Pi, you can plugin in a new disk drive, and open iOS client APP, go to settings tab and set the redundancy backup there.

## What file systems supported?

If you are on Windows or macOS, then you can use whatever file system supported by Windows or macOS.

If you are on Raspberry Pi, it supports "vfat exfat ext2 ext3 ext4 hfsplus ntfs fuseblk".

## Why folders named with date time seem not correct on hard drive?

The date time used to store on the system is in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time), not the time of local timezone, the reason is that the photo can be taken in different timezones, and the user may travel or relocate to different timezones, to simplify the processing, we use UTC timestamp, and it can easily convert to different timezones on the APP.

## How to setup a secondary backup?

There are several options to setup a secondary backup, check this [blog](/blog/2019/12/24/raspberrypi-hd/) for more details.

## Does Lomorage support backup edited file?

On iOS, if photo is edited, system will store the original photo, the edited one, as well as the editing operations, **Lomorage will store ONLY the edited photo**. For edited video, system will store the video before last editing, the editing operations as well as the edited one, and **Lomorage will ONLY store the edited video**.

If you would like to store the file before editing, make sure you have backup the edited one first, and then you can revert the editing in Apple's "Photos APP", and then upload those files before editing.

## What is background backup?

Background backup means you don't need to open Lomorage app to backup the assets. 

Background backup on iOS is not expected to work the same way as iCloud, Apple restricts 3rd party tools to run in the background. Currently there is only two hacks to trigger Lomorage running in the background, one is background fetch, which might be triggered when system is idle, another one is triggered when significant location changes, that is why background backup requires location permission. Both won't last long and can only run in background for a limited time.

Moving Lomorage app into background, the existing upload is still running in the background but the next upload has to wait either it's back to foreground or the above two hack condition triggers the upload.

## How to recover from Raspbian boot failure?

Don't worry, your Photo are stored on hard drive, and the database is backup to hard drive as well. You just need to recovery the backup database.

1. plugin in your hard drive to PC, and you can find that assets.db in each user's Lomorage home directory, they are exactly the same.
2. reinstall Lomorage Raspbian image.
3. attach hard drive to Raspberry Pi.
4. copy assets.db from one user's Lomorage home directory on hard drive to `/opt/lomorage/var/` on Raspberry Pi.
5. restart Lomorage service on Raspberry Pi: `sudo service lomod restart`.

This applies to Armbian setup as well.

## I forget password, how to reset?

Don't worry, you can alway reset password by running `/opt/lomorage/bin/lomoc user reset [user name] [password]` at Linux. `username` is username reset for, and `password` is new password you like to use.

And if you are using Mac LomoAgent, you can reset user's password in user list by clicking "Users" menu.

For Windows, you can download the command line tool [here](https://aisnote.com/wp-content/uploads/2021/05/lomoc.zip), open cmd 
run below command line, replace "your_user_name" and "new_password_in_clear_txt":

```
cd c:\Users\%username%\AppData\Local\lomoware\Lomoagent\lomod\
lomoc user reset –db “c:\Users\%username%\AppData\Local\lomoware\var\assets.db” your_user_name new_password_in_clear_txt
```

## What can it do besides photo backup and management?

**Lomorage is focus on photo backup and management and our current goal is to make it easy to use, stable and reliable.** But we are using a customized open Linux platform, so if you need some of those features on expensive NAS, you should be able to install the alternatives, for example you can install [Transmission](https://transmissionbt.com/) for downloading, and [Jellyfin](https://jellyfin.org) for media center, [samba share](https://www.techrepublic.com/article/how-to-connect-to-linux-samba-shares-from-windows-10/) is enabled by default for backup other files.

## What is the size of storage?

Lomorage relies on external storage and supports all types of hard drive and flash disk.

## Can it connected with multiple hard drives?
Yes, but you need powered USB hub to support multiple hard drives.

## Can I use spare hard drive?
Yes, you don't need reformat the disk to use Lomorage, and it supports all major file systems(FAT32, NTFS, EXT etc).

## Does it support hard drive sleep?
Yes, once no activity on hard drive, it goes to sleep mode automatically, and will wake up once you access the hard drive。

## How to install?
Connect hard drive via USB, connect ethernet, power on, and download Lomorage APP.

## How to view the backup photos?
You can use Lomorage APP on iOS or Android, or you can use the Web APP, or you can access via samba, or even access the hard drive directly. We also have Android TV APP.

## Does it support remote access?
Yes, you can use 3rd party reverse proxy tunnel service(like ngrok), or you can set port mapping on router.

## Does it support export from backup to Phone?
Yes, currently works on iOS, you can "Save" those backups locally, and local will keep a copy, if you save it locally on multiple devices, you will have multiple copies and delete the copy won't delete the original backup.

## Can't upgrade server in Linux?
We have change the repository link from "lomorage.github.io" to "lomoware.lomorage.com", please change "/etc/apt/sources.list.d/lomoware.list" accordingly.

---

> In case you haven't found the answer to your question please feel free to [contact us](/contact), we will be happy to help you.
