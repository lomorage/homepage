+++
title = "FAQ"
description = "Frequently asked questions"
keywords = ["FAQ","How do I","questions","what if"]
+++

* [1. Why not just use cloud?](#1-why-not-just-use-cloud)
* [2. How about NAS?](#2-how-about-nas)
* [3. Any other similiar solutions?](#3-any-other-similiar-solutions)
* [4. Why Lomorage?](#4-why-lomorage)
* [5. What is the cost?](#5-what-is-the-cost)
* [6. How comes the name "Lomorage"?](#6-how-comes-the-name-lomorage)
* [7. What is the business model?](#7-what-is-the-business-model)
* [8. How to setup redundancy backup?](#8-how-to-setup-redundancy-backup)
* [9. What file systems supported?](#9-what-file-systems-supported)
* [10. Why the date time seems not correct?](#10-why-the-date-time-seems-not-correct)
* [11. How to set a secondary backup?](#11-how-to-set-a-secondary-backup)
* [12. Does Lomorage support backup edited file?](#12-does-lomorage-support-backup-edited-file)
* [13. What is background backup?](#13-what-is-background-backup)

## 1. Why not just use cloud?

We believe the digital assets should be taken care by ourselves, store locally, backup locally, that is the primary, and cloud backup is the tertiary backup, a good complementary, the price of existing cloud storage is too high, and some of the companies(Shoebox, Canon Irista) doing the business gradually shutdown the services, this is a money losing business, it’s not the efficient way to manage huge amount of assets centralized (flicker CEO’s [open letter](https://www.theverge.com/2019/12/19/21030795/flickr-pro-smugmug-don-macaskill-open-letter) sent last year confirmed this), they have to either make it more expensive, or make you the product. Cloud service is convenient for the user, people don’t need to buy expensive hardware, don’t need to be the professionals to maintain that, don’t need to worry about the energy fee to keep it run 24x7, but things are changing, single board computers are getting cheaper, more powerful and more energy efficient, storage are getting cheaper with larger capacity, software are getting more intelligent, people are having more and more concerns about the privacy, it’s now viable to host the Photo service, your private cloud, at your own place.

## 2. How about NAS?

If you haven't heard of NAS before, then NAS will not be your best option. [NAS](https://en.wikipedia.org/wiki/Network-attached_storage) is a general storage that can store everything, it also comes with application that can backup and management your photos and videos. Even though some NAS tried to make it easy to use, and make the operating system looks like Windows, but still it's too complicate for non-technical users when they tried to understand what is, think about buy a NAS for your parents and let them setup it up. Take a look at the [user guide](https://global.download.synology.com/download/Document/Software/UserGuide/Firmware/DSM/3.1/enu/Syno_UsersGuide_NAServer_enu.pdf) it's just way too much for a photo back and management.

## 3. Any other similiar solutions?

Yes, there are other products which focuses on the vertical market, let user hosts the Photo service locally but simplies the setup and use.

  - [ibi - The Smart Photo Manager](https://www.amazon.com/ibi-Organize-Privately-Smartphones-Accounts/dp/B07Y9CH817/ref=cm_cr_arp_d_product_top?ie=UTF8) with 1TB storage (**$119.99**)
  - [Monument Photo Management Device](https://www.amazon.com/Monument-Photo-Management-Device-Automatically/dp/B01M8I40A6/ref=sr_1_3?dchild=1&keywords=ibi&qid=1588828193&sr=8-3) NO hard drive (**$169.94**)
  - [Kwilt3 Personal Cloud Storage Device](https://www.amazon.com/Kwilt3-Personal-External-Storage-Wireless/dp/B07KQHVMJX/ref=psdc_13436301_t3_B01M8I40A6?th=1) NO hard drive (**$99**)
  - [CatDrive Your Private Shared Memory](http://www.halos.co/catdrive/)(**out-of-service**)

## 4. Why Lomorage?

Simple, we are not satisfied with existing solutions.

1. Cloud can be the tertiary complementary backup, not the primary, nor the secondary.
   - We currently support redandency backup locally
   - We plan to support remote backup (like backup to your parents' Lomorage setup) and cloud backup like [backblaze](https://www.backblaze.com/).

2. Easy to setup, easy to use, easy to upgrade, zero maintenance.
   - It only takes a few minutes to install the prebuild OS image on Raspberry Pi.
   - We support backup to Windows and MacOS as well with one single application.
   - software upgrade automatically.
   - System migrate automatically to gurantee compatibility.

3. Software matters, it need to be solid to take care of those invaluable assets.
   - We are the user, we eat our own dog food.
   - We release by quality not by date.

4. It should be open, avoid any kind of lock down, the user should easily migrate to other systems, and should not get a electronic waste if the product is out of service.
   - Media files are stored as it's on your disk, original format, original resolution, exactly the same.
   - You don't need format your hard drive to use it,  and it supports all porpular file systems.
   - Media files are organized in folders by "YYYY/MM/DD" struture on disk, you can easily import them to other systems/tools.
   - The setup use Raspberry Pi, even if you don't use Lomorage, it's still a single board computer you can use in [tons of projects](https://projects.raspberrypi.org/en).

5. More than backup and management, enjoy the memories with your families.
   - How many times you open photo APP and take a look the old photos?
   - Have dozons of photo frames but hard to find enough space for them?
   - Have idle digital photo frame which requires copy/paste files, limited in storage?
   - Think about having a large screen digital signage in your living room which shows weather, news, digital arts and selected photos, and several other smaller digital photo frames in your bedroom or study room which shows your personal photos and videos. No more copy/paste, break the storage limit and use WiFi to retreive photos from Lomorage.
   - Reuse any idle screens to build digital frames with wireless connection using Raspberry Pi, customize the content on your Phone.
   - share your kids photo to their grandparents' digtal frame.

6. Stay connected while independant.
   - You can have Lomorage setup at your home, and your parents or your friends can have their own setup. They are operating indendantly, but can talk to each other when necessary, and they can as backup for each other.

## 5. What is the cost?

Lomorage is more cost efficient and more flexible compared with existing solutions, the software cost you nothing, and even get the hardware setup using Raspberry Pi 4 is cheaper compared with existing solutions.  If you use the Windows or Mac application, it's $0. There are some advanced features currently missing but are planned, and the basic backup feature is solid and stable for almost 2 years, no hidden fees, no lock down, no privacy concern, why not give it a try?

See [here](/compare) for comparison with cloud service, NAS and other solutions.

## 6. How comes the name "Lomorage"?

If you know what Lomography is, then "Lomorage" is just a combination of "Lomography" and "Storage".

## 7. What is the business model?

It's hard.

At this moment, we are making no money.

This is a side project starts with 3 fathers seeking a better solution for the digital assets for the family and we are doing that in spare time, we have been doing this for two years. We started this with love and build it with love, and we use it in our daily life, we do spend a lot of time on that, but we know we probably will do this even nobody is paying us, because that is what we need, and the way we do this doesn’t cost us much, the only thing we paid for now it’s the apple developer account and a domain name, we don’t host the storage, we don’t offer the device, we host website and software download at github for free, so the answer why it’s free it’s because we can.

Nothing is free, and need to make money to make it sustainable, we wish we can do that full time to get the features delivered faster, but we just can't at this stage. We will be happy if people find the product useful and willing to spend money on that, for now the product is at early stage with basic features like backup and share, and we provide that as Freemium. We don’t have to make user part of the products, and we care the privacy since day one because we are ourself the user. 

Peter Thiel said: "To build a successful startup, you have to be **10 times better** than second best.” , and we  also believe: to make money out of something, we need to build something that is valuable first.

We are planning to release more advanced features (like advanced search, remote backup, digital frame etc), and will probably think about monetize some of them. And the digtial photo frame as a dominate screen in the room, there is also possibilities to monetize.

## 8. How to setup redundancy backup?

If you are running Lomorage service on macOS (Windows haven't support yet), you can open the settings window of LomoAgent application, and set the redundancy backup there.

If you are running Lomorage service on Raspberry Pi, you can plugin in a new disk drive, and open iOS client APP, go to settings tab and set the redundancy backup there.

## 9. What file systems supported?

If you are on Windows or macOS, then you can use whatever file system supported by Windows or macOS.

If you are on Raspberry Pi, it supports "vfat exfat ext2 ext3 ext4 hfsplus ntfs fuseblk".

## 10. Why the date time seems not correct?

The date time used to store on the system is in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time), not the time of local timezone, the reason is that the photo can be taken in different timezones, and the user may travel or relocate to different timezones, to simplify the processing, we use UTC timestamp, and it can easily convert to different timezones on the APP.

## 11. How to set a secondary backup?

There are several options to setup a secondary backup, check this [blog](/blog/2019/12/24/raspberrypi-hd/) for more details.

## 12. Does Lomorage support backup edited file?

On iOS, if photo is edited, system will store the original photo, the edited one, as well as the editing operations, **Lomorage will store ONLY the edited photo**. For edited video, system will store the video before last editing, the editing operations as well as the edited one, and **Lomorage will ONLY store the editied video**.

If you would like to store the file before editing, make sure you have backup the edited one first, and then you can revert the editing in Apple's "Photos APP", and then upload those files before editing.

Notice: The old iOS client (<0.6.10) doesn't support edited files, so if you have error when uploading the edited files, please delete old client and reinstall the new one, instead of upgrading to new version, to make sure the old problematic database is removed.

## 13. What is background backup?

Background backup means you don't need to open Lomorage app to backup the assets. 

Background backup on iOS is not expected to work the same way as iCloud, Apple restricts 3rd party tools to run in the background. Currently there is only two hacks to trigger Lomorage running in the background, one is background fetch, which might be triggered when system is idle, another one is triggered when significant location changes, that is why background backup requires location permission. Both won't last long and can only run in background for a limited time.

Moving Lomorage app into background, the existing upload is still running in the background but the next upload has to wait either it's back to foreground or the above two hack condition triggers the upload.

---

> In case you haven't found the answer to your question please feel free to [contact us](/contact), we will be happy to help you.

