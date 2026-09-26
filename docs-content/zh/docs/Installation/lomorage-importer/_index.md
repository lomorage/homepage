---
weight: 13
bookFlatSection: true
title: "导入工具"
---

# 最近更新: 07/19/2022

# 什么是Lomorage 导入工具


Lomorage 导入工具是把照片和视频批量导入到Lomorage系统的桌面程序。

它可以将Google Photo 下载下来的 ZIP 文件直接导入Lomorage系统，方便快捷。

也支持把本地现有的文件导入到Lomorage，选择某个目录或者批量选择文件

目前该工具支持 **Windows and MacOS**.

# 下载

可以去Github [Lomo-importer@github](https://github.com/lomorage/lomo-importer-release) 下载最新的可执行程序。

## 最新导入工具下载链接

**如果您使用的是Windows的Lomorage照片助手，可以直接从照片助手程序界面启动导入工具，而无需再下载该导入工具！**

- Windows [点击下载最新导入工具](https://lomorage.com/windows/LomoImporter.zip)

- MacOS [LomoImporter.app2021-08-31_14-13-34_mac.zip](https://lomorage.com/mac/LomoImporter.zip)


# 快速使用视频

<iframe width="560" height="315" src="https://www.youtube.com/embed/6dsxfmWZkoI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


# 例子: 如何批量导入某个文件夹（目录）里的所有图片和视频文件
1. 按如下界面登录Lomorage

<div align="center">

  <p class="screenshoot" />
  <img width="80%" src="/img/installation/lomorage-importer/login.jpg">

</div>

2. 点击 按钮 **“1.Select Folder..."**, 选择你需要导入的目录，程序会自动遍历该目录下的文件夹，并显示在界面上
3. 等分析完毕， 点击按钮 **“2.Start Import"**，如下图所示：

<div align="center">

  <p class="screenshoot" />
  <img width="80%" src="/img/installation/lomorage-importer/start.jpg">

</div>

# 例子: 如何批量导入Google Photo的 ZIP 文件

1. 第一步是去 takeout.google.com 把所有的照片下载下来，不需要解压

2. 按如下界面登录Lomorage

<div align="center">

  <p class="screenshoot" />
  <img width="80%" src="/img/installation/lomorage-importer/login.jpg">

</div>

3. 点击 按钮 **“1.Add Files..."**, 选择你需要导入的ZIP 文件，等分析完成后， 点击按钮 **“2.Start Import"**，如下图所示：

<div align="center">

  <p class="screenshoot" />
  <img width="80%" src="/img/installation/lomorage-importer/start_zip.jpg">

</div>

有任何问题，请与我们联系：support at lomorage dot com

## 从已有目录中导入媒体文件
如果用户有一些媒体文件存储在已有的USB硬盘或者本地磁盘，或者远程mount的磁盘，并且希望可以直接导入到本系统里面，除了使用importer tool，也可以使用lomoc来完成，这样可以避免额外的网络流量。缺省情况下，lomoc会删除旧文件，移动到新目录下，但是如果用户指定`--no-move`选项，则旧文件会仍然保留在已有的目录中，"Lomorage照片助手"不会做任何操作。所有的导入日志存储在`/opt/lomorage/var/log/import_[import directory].log`里面。
```
$ /opt/lomorage/bin/lomoc import -h
NAME:
   lomoc import - Import all photos from given directory into lomo backend with given username and password

USAGE:
   lomoc import [command options] [username] [password] [directory]

OPTIONS:
   --port value, -p value  (default: 8000)
   --no-move, -n           not moving original photos/videos, and only insert record in db
```

需要注意事项:
 - 缺省情况下，lomod在端口8000监听，如果用户改变了监听端口，需要设置`--port`来指定新的监听端口`。
 - 缺省情况下，导入会删除旧文件，移动到新目录下，但是如果用户指定`--no-move`选项，则旧文件会仍然保留在已有的目录中，"Lomorage照片助手"不会做任何操作。

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
FINISH: totally scanned 1 directories, and imported 12 media files
```
## 通过USB导入

您可以直接通过USB来访问iPhone/Android，和无线方式比，这样导入比更快，特别是有大量照片的情况下。

### iOS

如果您使用Windows 11，照片会自动加载到电脑中，您可以直接在文件系统里访问。

如果您使用Linux，可以参考[这里](https://opensource.com/article/21/8/libimobiledevice-iphone-linux)来安装libimobiledevice和ifuse来将iPhone的存储加载到文件系统中。照片目录加载到文件系统后，您就可以使用上述的导入工具来进行照片的导入了。

如果您使用macOS，您依旧可以使用类似的工具，先安装libimobiledevice，但ifuse在macOS上不可用，您需要安装[osxfuse](https://github.com/osxfuse/osxfuse/releases)和[ifuse-mac](https://github.com/gromgit/homebrew-fuse)，您可以使用brew来安装ifuse-mac: `brew install gromgit/fuse/ifuse-mac`

### Android
TODO

# 以往更新: 08/19/2021
- 更新windows版本:发布64位版本，大于4G的文件直接导入
- 可配置导入线程数
## 以往更新: 07/26/2021
- 提高了导入速度
- 支持Lomo 动态图片格式
- 修复内存泄漏
- 修复退出时弹框问题

## 以往更新：07/14/2021
- 支持导入目录：直接选择某个目录，程序会遍历该目录下所有的文件
