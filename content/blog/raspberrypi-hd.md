+++
title = "Setup Lomorage secondary backup with Raspberry Pi"
tags = ["Raspberry Pi", "secondary backup", "Hard Disk", "Flash Drive", "USB Hub", "Restore"]
categories = ["FAQ"]
date = "2019-12-24T13:43:40"
banner = "img/banners/power-hub-adafruit.jpg"
+++

Photos and video are valuable assets, having a single backup is not enough, we at least should have secondary backup besides the primary backup, and ideally one more remote backup. Lomorage currenlty provide the option to setup a secondary backup. There are several options to do this.

<!--more--> 

Table of Contents
=================

   * [Setup Lomorage secondary backup with Raspberry Pi](#setup-lomorage-secondary-backup-with-raspberry-pi)
      * [Option 1 (1 USB hard drive, 1 USB flash drive on same Raspberry Pi)](#option-1-1-usb-hard-drive-1-usb-flash-drive-on-same-raspberry-pi)
      * [Option 2 (2 USB hard drive on same Raspberry Pi)](#option-2-2-usb-hard-drive-on-same-raspberry-pi)
      * [Option 3 (2 USB hard drive on 2 separate Raspberry Pis)](#option-3-2-usb-hard-drive-on-2-separate-raspberry-pis)
      * [Option 4 (1 USB drive one Raspberry Pi, NAS)](#option-4-1-usb-drive-one-raspberry-pi-nas)
   * [Restore from the secondary backup](#restore-from-the-secondary-backup)

# Setup Lomorage secondary backup with Raspberry Pi

You can choose the option suits your need.

## Option 1 (1 USB hard drive, 1 USB flash drive on same Raspberry Pi)

Raspberry Pi should have no problem to power one USB hard drive, you can even add one more USB flash drive. Since nomrally, a hard drive is expected to have [a much longer lifespan](https://www.datanumen.com/blogs/usb-flash-drive-vs-external-hard-drive-better-storing-data/), and USB flash drive has [limited number of write/erase cycles](https://www.flashbay.com/blog/usb-life-expectancy), it's better to use hard drive as the primary storage and USB hard drive.

## Option 2 (2 USB hard drive on same Raspberry Pi)

Most likely, Raspberry Pi won't be able to provide that much power two USB hard drives. You can use the USB hub with power supply, which means the USB hard drive will be powered by the USB hub instead of Raspberry Pi.

- [USB 2.0 7-Port Hub with 15W Power Adapter from Plugable Technologies](https://www.walmart.com/ip/Plugable-USB-Hub-USB-2-0-7-Port-15W/134245816)

- [USB 2.0 Powered Hub - 7 Ports with 5V 2A Power Supply](https://www.adafruit.com/product/961)

## Option 3 (2 USB hard drive on 2 separate Raspberry Pis)

It would be safer if you have two setups in different places, the Lomorage OS image already enabled Samba file share service by default, so what you can do it's actually mount the hard drive of the secondary setup in the the first setup.

For example, if secondary Pi has ip "192.168.1.155", the driver is mount at "/media/WD_90C27F73C27F5C82".

One the primary Pi, we can use the following command to mount it, just change the ip address and mount directory according to your setup.

```
mkdir /media/WD_90C27F73C27F5C82

# user pass is the username password on 2nd Pi, that is the default.
# uid 1000 and gid 1000 is for mount it as user Pi on 1st Pi
sudo mount.cifs //192.168.1.155/media/WD_90C27F73C27F5C82 /media/WD_90C27F73C27F5C82 -o user=pi,pass=raspberry,uid=1000,gid=1000
```

You can also add the entry in "/etc/fstab", so that it can mount when system start:

```
//192.168.1.155/media/WD_90C27F73C27F5C82  /media/WD_90C27F73C27F5C82  cifs  user=pi,pass=raspberry,uid=1000,gid=1000
```

You can use the following command to umount and mount all entries in fstab to validate the configuration:

```
sudo mount -a
sudo umount -a
```

**Notice: Don't use the secondary Lomorage service even though it can be found, since we are using the primary one and set redancency backup to the directory mounted via Samba. Currently we don't have GUI to set the backup this way, you have to do that manually in commandline, will add GUI later**

## Option 4 (1 USB drive one Raspberry Pi, NAS)

You can also reuse your NAS and follow the similiar steps above in Option 3 to mount the NAS storage via Samba.

The parameters needed are:

- samba service ip (192.168.1.155)

- samba shared directory name (WD_90C27F73C27F5C82)

- local mount root directory (on Raspberry Pi is "/media" if using Lomorage OS image; If not, it and can be changed via "--mount-dir" command line args when running lomod;)

- username/password for Samba service

# Restore from the secondary backup

If unfortunately the hard drive on your primary device is dead, you can bring up the secondary setup as primary one. The photo and video assets are already backup on the secondary hard drive, as well as the database. You can copy the "assets.db" in the user directory on hard drive to "/opt/lomorage/var/assets.db", and change the "home_dir" in table "user" for each user in "assets.db". We promise will let this process less painful, but for now, you have to do that manually, if you have the problem and can't figure it by yourself, join our [slack channel](https://join.slack.com/t/lomorage/shared_invite/enQtODc4MTE5ODQzNzkyLTRlY2U4MTQ1YjczYjBhMDcwMmExYTUxNTg2NTE5YmRkZjg2ZWQwZjg1MjEwMjQzZWVjMmEwZjk3ZGIyODY4ODM) or reach us via [email](mailto: support@lomorage.com), and we will help you solve it.

