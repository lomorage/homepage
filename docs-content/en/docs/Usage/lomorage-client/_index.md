---
title: Lomorage Command Line Client
weight: 11
---

# Lomorage Command Line Client

Lomorage command line client is a tool to allow user to control backend directly. Its name is `lomoc` and installed under /opt/lomorage/bin. It provides some options to configure the backend.

## Reset user's backup home directory and backup directory

After one user is created through mobile application, people can use `lomoc` command line option to reset home directory and backup directory. Firstly, people need copy specific user's or all users' asset directories to the new directory. For example, if new media directory is `/media/newdisk`, and there are 2 users `alice` and `bob`, the new tree would be like
```
/media/newdisk/
|-- alice
|   `-- Photos
|       |-- master
|       |   |-- 2003
|       |   |   |-- 01
|       |   |   |   `-- 17
|       |   |   |       `-- 20030117_4.jpg
|       |   |   `-- 11
|       |   |       |-- 01
|       |   |       |   |-- 20031101_2.jpg
|       |   |       |   `-- 20031101_3.jpg
|       |   |       `-- 23
|       |   |           |-- 20031123_1.jpg
|       |   |           |-- 20031123_11.webp
|       |   |           |-- 20031123_12.dng
|       |   |           `-- 20031123_13.heic
|       |   |-- 2004
|       |   |   `-- 01
|       |   |       `-- 21
|       |   |           `-- 20040121_5.jpg
|       |   `-- 2013
|       |       |-- 07
|       |       |   `-- 28
|       |       |       `-- 20130728_7.png
`-- bob
    `-- Photos
        |-- master
        |   `-- 2013
        |       |-- 08
        |       |   `-- 08
        |       |       `-- 20130808_6.mp4
        |       `-- 11
        |           `-- 23
        |               |-- 20131123_10.zip
        |               |-- 20131123_10_image.heic
        |               |-- 20131123_8.zip
        |               |-- 20131123_8_image.jpg
        |               `-- 20131123_9.heic
```

Note:
 - If `[user name]` is supplied, it only updates the given user's home directory or backup directory; otherwise, it will replace all users' home directory or backup directory to the new given media directory.
 - By default, the client will read data from /opt/lomorage/var/assets.db. If you installed the lomod to different directory, you can use `--db` option to supply new DB file location
```
$ /opt/lomorage/bin/lomoc reset home-dir -h
NAME:
   lomoc reset home-dir - reset users' home directory in DB, and input dir must be media dir. If username is not specified, it will reset all users' home directory

USAGE:
   lomoc reset home-dir [command options] [new media dir] ([user name])

OPTIONS:
   --db value  db filename with full path (default: "/opt/lomorage/var/assets.db")

$ /opt/lomorage/bin/lomoc reset backup-dir -h
NAME:
   lomoc reset backup-dir - reset users' backup directory in DB, and input dir must be media backup dir. If username is not specified, it will reset all users' backup directory

USAGE:
   lomoc reset backup-dir [command options] [new backup dir] ([user name])

OPTIONS:
   --db value  db filename with full path (default: "/opt/lomorage/var/assets.db")

```

## Import from one existing folders
Command line tool is for advanced user when the existing assets are in attached USB or Local/NFS/CIFS mounted disks along with  "Lomorage Photo Assistant". It can avoid unnecessary back-and-forth network traffic as well as disk operation. During import, the tool will move existing assets to the directories created by lomorage for each user, or not move asset while inserting record only if supply `--no-move` option. All import logs are saved under /opt/lomorage/var/log/import_[import directory].log. Below is usage for the tool.

**Should be notice that the import will creates albums automatically according to the directories structures**

```
$ /opt/lomorage/bin/lomoc import -h
NAME:
   lomoc import - Import all photos from given directory into lomo backend with given username and password

USAGE:
   lomoc import [command options] [username] [password] [directory]

OPTIONS:
   --port value, -p value  (default: 8000)
   --no-move, -n           not moving original photos/videos, and only insert record in db
   --no-video, --nv        not scan video files. This is to speed up the first import process
```

Note:
 - `--port` is listen port of `lomod` backend service. It is 8000 by default.
 - `--no-move` is to hint backend service not moving assets, and only insert record in DB. By default it is false, and import will **MOVE** all assets and consolidate them into one location
 - `--no-video` is to hint backend service not scanning video files. This is to speed up the first import process. Since backend always check assets exists or not by their SHA, you can safely import video at the 2nd time.

Example:
```
$ /opt/lomorage/bin/lomoc import alice password /media/STEC_838C-1111/test/video
-m
Login localhost successfully
import photos/videos from /media/STEC_838C-1111/test
please check import log /opt/lomorage/var/log/import_media_STEC_838C-1111_test.log

$ cat /opt/lomorage/var/log/import_media_STEC_838C-1111_test.log
start import /media/STEC_838C-1111/test/img/11_2014_01_21.webp
finish import /media/STEC_838C-1111/test/img/11_2014_01_21.webp to /media/STEC_838C-1111/alice/Photos/master/2021/09/20/20210920_9391.webp
start import /media/STEC_838C-1111/test/img/12_2014_01_21.heic
finish import /media/STEC_838C-1111/test/img/12_2014_01_21.heic to /media/STEC_838C-1111/alice/Photos/master/2021/09/20/20210920_9392.heic
start import /media/STEC_838C-1111/test/img/14_2017_09_13.heic
finish import /media/STEC_838C-1111/test/img/14_2017_09_13.heic to /media/STEC_838C-1111/alice/Photos/master/2017/09/13/20170913_9393.heic
start import /media/STEC_838C-1111/test/img/1_2003_01_17.jpg
finish import /media/STEC_838C-1111/test/img/1_2003_01_17.jpg to /media/STEC_838C-1111/alice/Photos/master/2003/01/17/20030117_9394.jpg
start import /media/STEC_838C-1111/test/img/3_2003_11_01.jpg
finish import /media/STEC_838C-1111/test/img/3_2003_11_01.jpg to /media/STEC_838C-1111/alice/Photos/master/2003/11/01/20031101_9395.jpg
start import /media/STEC_838C-1111/test/img/4_2003_11_01.jpg
finish import /media/STEC_838C-1111/test/img/4_2003_11_01.jpg to /media/STEC_838C-1111/alice/Photos/master/2003/11/01/20031101_9396.jpg
start import /media/STEC_838C-1111/test/img/5_2003_11_23.jpg
finish import /media/STEC_838C-1111/test/img/5_2003_11_23.jpg to /media/STEC_838C-1111/alice/Photos/master/2003/11/23/20031123_9397.jpg
start import /media/STEC_838C-1111/test/img/6_2004_01_21.jpg
finish import /media/STEC_838C-1111/test/img/6_2004_01_21.jpg to /media/STEC_838C-1111/alice/Photos/master/2004/01/21/20040121_9398.jpg
start import /media/STEC_838C-1111/test/img/7_2004_09_12.webp
finish import /media/STEC_838C-1111/test/img/7_2004_09_12.webp to /media/STEC_838C-1111/alice/Photos/master/2004/09/12/20040912_9399.webp
start import /media/STEC_838C-1111/test/img/8_2008_12_14.dng
finish import /media/STEC_838C-1111/test/img/8_2008_12_14.dng to /media/STEC_838C-1111/alice/Photos/master/2008/12/14/20081214_9400.dng
start import /media/STEC_838C-1111/test/img/9_2013_07_28.png
finish import /media/STEC_838C-1111/test/img/9_2013_07_28.png to /media/STEC_838C-1111/alice/Photos/master/2021/09/20/20210920_9401.png
start import /media/STEC_838C-1111/test/img/preview.jpg
finish import /media/STEC_838C-1111/test/img/preview.jpg to /media/STEC_838C-1111/alice/Photos/master/2003/11/23/20031123_9402.jpg
FINISH: totally scanned 1 directories, and imported 12 media files
```
