# Feature Highlight

## Privacy Matters

Lomorage is a private cloud service which runs on your private network, which give your the convenience of cloud-based photo backup service, but without the concern of leaking privacy. We are not, and will never collect **ANY** user privacy data.

You can also setup multiple lomorage services in your private network, for different family members, which are complete isolated with each other.

<!--
You can also use either [DES]() to encrypt your photos, or use any [encrypted file system]() supported by the operating system.-->

## Cross Platfrom

There is no OS limitation for running the lomorage service, you can backup your photos on MAC, Windows and Raspberry Pi, and we will add other OS support upon user's request.

We only support iOS client now, the Android version and Web version are on our backlog, we are planning to release this year.

## Easy Setup

We are not building another NAS system, so if you want to backup and manage your photos, but get scared by the complicate setup process of NAS, just forget about the jargons and take easy. Lomorage setup is guaranteed to be within minutes. Check [here](/installation) for the installation guide.

## Keep original size

The photo and video are stored as original size on your disk, it will be exactly the same with the one taken on your phone. Live photo is also supported, and the image and video clips are stored together as zip file.


## No Lockdown

Unlike some cloud based file storage which split the file into smaller segaments, Lomorage will store the photo file as it's on the file system, we are not using any proprietary format.

Unlike some NAS system which require user to format the disk before using it as backup storage, with Lomorage, you can just plugin a spare disk with [popular file system](/faq/#4-what-file-systems-supported), it just works, you won't be locked to use specific file system, you can just use the file system you normally use, like FAT32/NTFS in Windows, thus you don't need 3rd party software to access the backup file.

## Near-zero Maintenance

Cloud service hides the complexity of the system, since Lomorage is a service deployed at user's network, we aim to provide same user experience with the cloud service, to minimize user intervention and maintenance.

  - self upgrade: Lomorage service can upgrade to newest version when available.

  - auto migration: Migration will be done automatically to make sure nothing breaks aftr upgrade.

  - consistency check: consistency check will be scheduled regularly to make sure no abnormal in the system.

<!--  - expandable storage: we provide several [options](https://www.lomorage.com/expand-stroage) to expand the storage which disk is out-of-space.-->

## Flexible backup options

Since most people will offload the phone storage, so having those backup once is not enough, Lomorage will provide several backup options:

  - Local redandency backup: you can backup multiple copies locally, just plugin in more disks and [setup the backup](/faq/#3-how-to-setup-redandency-backup) on your phone.

  - remote backup: you can backup to other Lomorage services setup by other family members or friends, with encryption. This is on the backlog, and plan to support this year.

<!--  - cloud backup: cloud backup on popular vendors is a good complementary. This is on the backlog, and plan to support this year.-->

## Share your moments

You can share moments with your family members, and create groups to share with multiple members at one time. It won't occupy your disk space so you don't need to worry about the disk usage on your phone.
