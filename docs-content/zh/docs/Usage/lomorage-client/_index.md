---
title: 命令行工具
weight: 11
---

# 命令行工具

命令行工具可以帮助高级用户做更多的控制使用，缺省安装目录是`/opt/lomorage/bin/lomoc`

## 重置用户的主目录和备份目录

当新用户通过手机创建成功以后，如果需要更改主目录或者备份目录，用户可以通过`lomoc import`的方式重置这些目录。重置前，请先把该用户已有的主目录和备份目录里面的所有内容拷贝到新的目录下。举例来说，如果新目录是`/media/newdisk`，有两个用户`alice`和`bob`需要重置，新目录的树结构应该是如下图所示
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

注意:
 - 如果输入命令时指定用户名，则只会改变指定用户的主目录或者备份目录；如果没有指定用户，就会更新所有用户的主目录或者备份目录
 - 缺省情况下，用户数据库位于`/opt/lomorage/var/assets.db`。如果安装过程中有更改，请使用`--db`选项来指定实际数据库位置
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

## 从已有目录中导入媒体文件
如果用户有一些媒体文件存储在已有的USB硬盘或者本地磁盘，或者远程mount的磁盘，并且希望可以直接导入到本系统里面，除了使用importer tool，也可以使用lomoc来完成，这样可以避免额外的网络流量。缺省情况下，lomoc会删除旧文件，移动到新目录下，但是如果用户指定`--no-move`选项，则旧文件会仍然保留在已有的目录中，"Lomorage照片助手"不会做任何操作。所有的导入日志存储在`/opt/lomorage/var/log/import_[import directory].log`里面。

**需要注意的是import导入会根据目录结构自动的创建相册**

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

需要注意事项:
 - 缺省情况下，lomod在端口8000监听，如果用户改变了监听端口，需要设置`--port`来指定新的监听端口`。
 - 缺省情况下，导入会删除旧文件，移动到新目录下，但是如果用户指定`--no-move`选项，则旧文件会仍然保留在已有的目录中，"Lomorage照片助手"不会做任何操作。
 - 缺省情况下，后台会导入图片和视频文件，由于视频文件的缩略图生成比较耗时，用户可以选择`--no-video`选项来忽略视频文件导入。由于每次导入后台会检查文件SHA，所以用户可以在第一次导入成功以后，再一次扫描并且导入视频文件。

导入日志范例:
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
