* [安装说明](#安装说明)
   * [1. 简介](#1-简介)
   * [2. 下载](#2-下载)
      * [Lomorage服务](#lomorage服务)
      * [Lomorage客户端](#lomorage客户端)
   * [3. 安装](#3-安装)
      * [Windows](#windows)
      * [macOS](#macos)
      * [树莓派](#树莓派)
      * [iOS](#ios)

# 安装说明

## 1. 简介

要使用Lomorage，您需要在本地网络运行Lomorage服务，您可以选择在Windows，macOS或者树莓派上运行。然后您需要下载手机客户端应用。

## 2. 下载

### Lomorage服务

您可以根据自己的喜好和需求来选择不同的平台安装Lomorage服务。Windows或macOS上运行Lomorage服务可以提供比树莓派上更好的性能，上传和下载的速度会更快，但没树莓派节约能源，7x24小时运行，一年下来电费不会超过30元。

<p align="center">

<a href="https://github.com/lomorage/LomoAgentWin/releases/download/lomoagent-2019_08_08.08_39_09.0.364163e/lomoagent.msi" title="Install Lomorage for Windows" class="badge windows">Windows</a>

 &nbsp;
 
<a href="https://github.com/lomorage/LomoAgentOSX/releases/download/2019_08_06.22_40_22.0.79b4818/LomoAgent.dmg" title="Install Lomorage for macOS" class="badge">macOS</a>

 &nbsp;
 
<a href="https://github.com/lomorage/pi-gen/releases/download/lomorage-v0.5/image_2019-08-01-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

### Lomorage客户端

现在支持者iOS，您可以在iPhone或者iPad上安装。现在还在beta测试阶段，点击[这里](mailto:support@lomorage.com)申请testflight访问权限。

<p align="center">
<a href="mailto:support@lomorage.com" title="Request testflight access" class="badge testflight">TestFlight</a>
</p>

<!--<p align="center">
<a href=""><img alt="Download on the App Store" src="/img/installation/app-store-ios.svg" width="220"></a>

 &nbsp;
 
<a href=""><img alt="Get it on Google Play" src="/img/installation/app-store-google.svg" width="220"></a>
</p>-->

## 3. 安装

第一步: 安装Lomorage服务。

### Windows

在Windows上双击运行Lomorage应用程序后，您需要设置数据目录，用来存储您的手机照片备份。

<p align="center">
  <img width="50%" src="/img/installation/windows-lomo-agent.png">
</p>

### macOS

在macOs上双击运行Lomorage应用程序后，您需要设置数据目录，用来存储您的手机照片备份。除此之前您也可以再多选择一个冗余备份目录，系统会每天定时进行冗余备。

<p align="center">
  <img width="50%" src="/img/installation/osx-lomo-agent.png">
</p>

### 树莓派

要在树莓派上运行，您需要先购买一个[树莓派](https://www.raspberrypi.org/)，Lomorage可以运行在以下型号的机器上:

- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

如果您还没有树莓派，我们建议购买新款的树莓派，会有更好的性能，我们很快会提供支持树莓派4的系统镜像。下面是您需要的最小配置:

- 树莓派主板
- 配套电源
- 16GB MicroSD卡

下载了[系统镜像](https://github.com/lomorage/pi-gen/releases/download/lomorage-v0.5/image_2019-08-01-lomorage-lite.zip)后, 你可以使用[balenaEtcher](https://www.balena.io/etcher/)将其安装到MicroSD卡, balenaEtcher提供Windows和macOS版本。

将MicroSD卡插入到台式电脑或笔记本的读卡器后，选择下载的系统镜像，选择MicroSD卡，点击“Flash“按钮，几分钟后就会安装完成。

<p align="center">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>

安装完后，将MicroSD卡插入到树莓派，接上USB移动硬盘，插入网线，接通电源，等待几分钟系统启动。

### iOS

您可以在iPad或iPhone上安装Lomorage客户端应用，最低支持的iOS系统版本是10.3。当前还处于beta测试阶段，您需要下载[testflight](https://apps.apple.com/us/app/testflight/id899247664)，然后在testflight中安装。testflight访问权限[申请](mailto:support@lomorage.com)。

安装完Lomorage客户端，启动就可以自动发现同一网络中运行的Lomorage服务，如果您有多台Lomorage服务运行，那些会列举出来供选择。

然后您可以创建用户，选择存储目录，登陆后，会花上几分钟来导入您相册的照片和视频，然后您可以选择需要上传的文件进行备份，如果已经备份成功，图片或视频下会显示一个绿色的小勾。在远程的选项卡里，显示的是远程备份过但本地没有的文件，所以如果您删除掉本地成功备份的文件，它们会显示在远程备份里面。

<div align="center">
<p class="screenshoot">
  <img width="30%" src="/img/installation/ios-mdns-discover.png">
  <img width="30%" src="/img/installation/ios-createuser.png">
  <img width="30%" src="/img/installation/ios-uploading.png">
  <img width="30%" src="/img/installation/ios-backup.png">
  <img width="30%" src="/img/installation/ios-settings.png">
  <img width="30%" src="/img/installation/ios-share.png">
</p>
</div>


<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"             title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
