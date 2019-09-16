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
      * [4. 外网访问](#4-外网访问)
         * [localtunnel](#localtunnel)
            * [1. 安装nodejs](#1-安装nodejs)
            * [2. 安装localtunnel](#2-安装localtunnel)
            * [3. 运行localtunnel](#3-运行localtunnel)
            * [4. 在Lomorage手机应用中配置隧道服务](#4-在lomorage手机应用中配置隧道服务)
         * [ngrok](#ngrok)
            * [1. 注册](#1-注册)
            * [2. 下载](#2-下载-1)
            * [3. 安装](#3-安装-1)
            * [4. 连接您的账号](#4-连接您的账号)
            * [5. 运行ngrok](#5-运行ngrok)
            * [6. 在Lomorage手机应用中配置隧道服务](#6-在lomorage手机应用中配置隧道服务)

# 安装说明

## 1. 简介

要使用Lomorage，您需要在本地网络运行Lomorage服务，您可以选择在Windows，macOS或者树莓派上运行。然后您需要下载手机客户端应用。

## 2. 下载

### Lomorage服务

您可以根据自己的喜好和需求来选择不同的平台安装Lomorage服务。Windows或macOS上运行Lomorage服务可以提供比树莓派上更好的性能，上传和下载的速度会更快，但没树莓派节约能源，7x24小时运行，一年下来电费不会超过30元。

<p align="center">

<a href="https://github.com/lomorage/LomoAgentWin/releases/download/2019_09_10.21_41_44.0.7a70c3b/lomoagent.msi" title="Install Lomorage for Windows" class="badge windows">Windows</a>

 &nbsp;
 
<a href="https://github.com/lomorage/LomoAgentOSX/releases/download/2019_09_11.23_30_31.0.bb65c8a/LomoAgent.dmg" title="Install Lomorage for macOS" class="badge">macOS</a>

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

首先需要安装Lomorage服务。

### Windows

<span>1.</span> 双击"lomoagent.msi"开始安装。如果有Windows Defender提示未知应用，请参考如下步骤允许安装程序运行。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-defender-1.png">
  <img width="50%" src="/img/installation/windows-defender-2.png">
</p>
</div>

<span>2.</span> 勾选"最终用户许可协议"后，一路完成安装步骤。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-install-1.png">
  <img width="50%" src="/img/installation/windows-install-2.png">
  <img width="50%" src="/img/installation/windows-install-3.png">
</p>
</div>

<span>3.</span> 双击桌面的LomoAgent图标，启动应用程序，如果有防火墙提示，请允许LomoAgent访问私有网络。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-firewall.png">
</p>
</div>

<span>4.</span> 程序启动后，**您需要设置数据目录才能正常使用**，数据目录用来存储您的手机上传的照片视频。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-lomo-agent.png">
</p>
</div>

### macOS

<span>1.</span> 双击"LomoAgent.dmg"开始安装，参考下面步骤完成安装。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/osx-install-1.png">
  <img width="50%" src="/img/installation/osx-install-2.png">
  <img width="50%" src="/img/installation/osx-install-3.png">
</p>
</div>

<span>2.</span> 运行应用程序LomoAgent，如果有防火墙提示，请允许LomoAgent访问网络。

<span>3.</span> 程序启动后，**您需要设置数据目录才能正常使用**，数据目录用来存储您的手机上传的照片视频。除此之前您也可以再多选择一个冗余备份目录，系统会每天定时进行冗余备。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/osx-lomo-agent.png">
</p>
</div>

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

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>
</div>

安装完后，将MicroSD卡插入到树莓派，接上USB移动硬盘，插入网线，接通电源，等待几分钟系统启动。

### iOS

您可以在iPad或iPhone上安装Lomorage客户端应用，最低支持的iOS系统版本是10.3。当前还处于beta测试阶段，您需要下载[testflight](https://apps.apple.com/us/app/testflight/id899247664)，然后在testflight中安装。testflight访问权限[申请](mailto:support@lomorage.com)。

安装完Lomorage客户端，启动就可以自动发现同一网络中运行的Lomorage服务，如果您有多台Lomorage服务运行，那些会列举出来供选择。如果未能自动发现服务，您可以选择扫码的方式登陆（Lomorage服务运行在Windows或者MacOS下，打开LomoAgent设置），或者手动输入IP地址和端口。

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

## 4. 外网访问

外网访问需要一点技术背景来进行手工设置，我们后续的版本会让这个设置更加简单。

外网访问依赖于隧道连接服务来实现内网穿透，现有一些服务提供商提供免费的服务，大多数隧道服务都需要下载客户端，运行在您的设备上，同公网的隧道服务器建立连接，并分配子域名，当通过子域名进行访问时，隧道服务就会将请求转发到您的应用程序。

您可以使用[localtunnel](https://localtunnel.me)或者[ngrok](https://ngrok.com)，这两个都是免费的隧道服务. localtunnel无需注册，并且支持自定义子域名，因此在Lomorage的树莓派镜像中已经预安装了localtunnel; ngrok需要注册，使用自定义子域名需要付费，但更加稳定，并没有额外的依赖。

*如果您使用Lomorage的树莓派镜像, 登陆的用户名是"pi"，密码是"raspberry"*

### localtunnel

如果您使用Windows或者macOS，您需要先先安装[nodejs](https://nodejs.org/)，再安装localtunnel。如果您使用Lomorage的树莓派镜像，localtunnel已经预装了，您可以跳过下面的步骤1和步骤2。

#### 1. 安装nodejs

下载并安装对应平台下的[二进制安装包]((https://nodejs.org/en/download/))。

#### 2. 安装localtunnel

打开命令行窗口并输入:

```
npm install -g localtunnel
```

#### 3. 运行localtunnel

如果您需要使用子域名"allice" (您可以选择自己的子域名), 打开命令行窗口并输入:

```
lt -s allice -p 8000 --print-requests
```

"-s"指定要使用的子域名, "-p"指定要转发的目的端口, Lomorage服务默认使用"8000", "--print-requests"输出接收到的请求信息。

如果输出结果没有任何错误，并输出类似如下的内容:

```
your url is: https://allice.localtunnel.me
```

您可以在浏览器窗口中打开localtunnel输出的url，如果您能在localtunnel的输出看到刚发出的访问请求日志，隧道服务就已经配置成功了。

```
Sat Aug 31 2019 11:38:00 GMT-0700 (PDT) GET /
```

<script id="asciicast-265358" src="https://asciinema.org/a/265358.js" async></script>

#### 4. 在Lomorage手机应用中配置隧道服务

打开Lomorage手机应用，在配置选项页里找到"外网服务"，设置地址为localtunnel输出的url，比如类似"allice.localtunnel.me"，端口为"443"。

### ngrok

#### 1. 注册

[注册](https://dashboard.ngrok.com/signup)ngrok，完成后，会显示"设置和安装"页面.

#### 2. 下载

ngrok只有一个二进制文件，您可以下载特定平台的版本。

如果您使用树莓派，您需要在"设置和安装"页面中拷贝Linux(ARM)版本的链接，当前是"https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip", 您可以通过"wget"来下载。

```
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
```

#### 3. 安装

解压缩得到二进制可执行文件。在Windows或macOS下，您可以双击解压，如果您使用树莓派，可以使用unzip命令

```
unzip ngrok-stable-linux-arm.zip
```

#### 4. 连接您的账号

在"设置和安装"页面的第三步会显示"authtoken"，您需要在**命令行窗口**中运行如下命令将"authtoken"添加到配置文件。

```
./ngrok authtoken [your-authtoken-show-in-step-3]
```

#### 5. 运行ngrok

Lomorage服务默认运行在8000端口，ngrok的免费账号不能自定义子域名，ngrok运行成功后，会自动绑定一个随机子域名，这个子域名在下次ngrok重新启动时会变化。

```
./ngrok http 8000
```

#### 6. 在Lomorage手机应用中配置隧道服务

打开Lomorage手机应用，在配置选项页里找到"外网服务"，设置服务器地址为ngrok输出的url，比如类似"2e30eea5.ngrok.io"，端口为"443"。


<script id="asciicast-265359" src="https://asciinema.org/a/265359.js" async></script>


<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"             title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
