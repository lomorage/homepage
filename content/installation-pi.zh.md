目录
=================

   * [在树莓派上安装Lomorage服务程序](#在树莓派上安装lomorage服务程序)
      * [安装系统镜像](#安装系统镜像)
      * [Docker安装](#docker安装)
         * [1. 树莓派上安装Docker](#1-树莓派上安装docker)
         * [2. 获取Docker镜像](#2-获取docker镜像)
         * [3. 运行](#3-运行)
      * [APT安装](#apt安装)
         * [1. 添加lomoware源](#1-添加lomoware源)
         * [2. 安装Lomorage](#2-安装lomorage)
         * [3. 按需修改加载目录和运行用户](#3-按需修改加载目录和运行用户)
         * [4. 运行](#4-运行)

# 在树莓派上安装Lomorage服务程序

要在树莓派上运行，您需要先购买一个[树莓派](https://www.raspberrypi.org/)，Lomorage可以运行在以下型号的机器上:

- [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

如果您还没有树莓派，我们建议购买新款的树莓派，会有更好的性能。下面是您需要的最小配置:

- 树莓派主板
- 配套电源
- 16GB MicroSD卡

**有3种方式来在Raspberry Pi上安装Lomorage服务程序**, 一种是安装预编译好的系统镜像，该镜像已经安装了所有Lomorage服务程序依赖的库和第三方工具，简单快捷，推荐使用；如果您已经有树莓派在运行其他服务，您也可以使用Docker镜像来安装，或者使用从APT源安装。

## 安装系统镜像

预装的系统镜像包括所有的包:

- lomo-backend: Lomorage服务程序

- lomo-web: Lomorage网页程序

- lomo-base: 系统工具，包括网络配置，开关控制, 磁盘加载, 蓝牙控制台

- lomo-frame: 数码相框程序

点击下面的链接下载系统镜像。

<p align="center">
<a href="https://github.com/lomorage/pi-gen/releases/download/2021_01_17.00_33_39.0.f0245af/image_2021-01-17-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

下载了系统镜像后, 你可以使用[balenaEtcher](https://www.balena.io/etcher/)将其安装到MicroSD卡, balenaEtcher提供Windows和macOS版本。

将MicroSD卡插入到台式电脑或笔记本的读卡器后，选择下载的系统镜像，选择MicroSD卡，点击“Flash“按钮，几分钟后就会安装完成。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>
</div>

安装完后，将MicroSD卡插入到树莓派，接上USB移动硬盘，插入网线，接通电源，等待几分钟系统启动。

如果您连接了HDMI，系统启动完成后，会提示没有找到资源，也会显示一个二维码用来绑定Lomorage相框，**请先在iOS/Android手机应用上创建用户，然后再扫码绑定Lomorage相框**，您可以使用Lomorage手机应用程序上传照片，然后按"r"键重新扫描。如果您想退出到控制台做一些系统配置，可以按"ESC"退出，然后按"Ctrl+Alt+F2"切换到控制台，配置完成后，可以使用命令`sudo service supervisor restart`来启动Lomorage相框程序。

*默认的用户名是"pi"，密码是"raspberry"*

为了更好的性能，建议使用有线网络连接，但如果您想使用WiFi, 您可以登陆树莓派，并使用下面的命令来启用无线连接`wifi_switch.sh client wifi-ssid wifi-password`，将 "wifi-ssid"和"wifi-password"替换为您的无线网络名和密码。*如果您的无线网络名称中有中文字符或者空格，就需要用引号，比如`wifi_switch.sh client "Lomorage的 无线" mypassword`*

## Docker安装

在已有的系统上使用Docker镜像安装非常方便。这种方式不适用于树莓派0和树莓派1。

Docker镜像包括:

- lomo-backend: Lomorage服务程序

- lomo-web: Lomorage网页程序

### 1. 树莓派上安装Docker

*注意: 如果您使用OMSC，需要修改“/etc/os-release”文件，将其中的"id=osmc"替换为"id=raspbain"*

```
sudo apt install -y ca-certificates
sudo update-ca-certificates --fresh
curl -fSLs https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
sudo systemctl start docker
```

### 2. 获取Docker镜像

从docker hub拉取镜像文件。

```
sudo docker pull lomorage/raspberrypi-lomorage:latest
```

### 3. 运行

下载[run.sh](https://raw.githubusercontent.com/lomorage/lomo-docker/master/run.sh)。

您可以指定媒体存储目录和Lomorage运行目录，不指定会使用默认值，您**必须**指定host, subnet, gateway, network-interface, vlan-address参数。

```
run.sh [-m {media-dir} -b {lomo-dir} -d -p {lomod-port} -P {lomow-port} -i {image-name}] -h host -s subnet -g gateway -n network-interface -a vlan-address

Command line options:
    -m  DIR         Absolute path of media directory used for media assets, default to "/media", optional
    -b  DIR         Absolute path of lomo directory used for db and log files, default to "/home/jeromy/lomo", optional
    -h  HOST        IP address or hostname of the host machine, required
    -s  SUBNET      Subnet of the host network(like 192.168.1.0/24), required
    -g  GATEWAY     gateway of the host network(like 192.168.1.1), required
    -n  NETWORK_INF network interface of the host network(like eth0), required
    -a  VLAN_ADDR   vlan address to be used(like 192.168.1.99), required
    -p  LOMOD_PORT  lomo-backend service port exposed on host machine, default to "8000", optional
    -P  LOMOW_PORT  lomo-web service port exposed on host machine, default to "8001", optional
    -i  IMAGE_NAME  docker image name, for example "lomorage/raspberrypi-lomorage:[tag]", default "lomorage/raspberrypi-lomorage:latest", optional
    -d              Debug mode to run in foreground, default to 0, optional

Examples:
    # assuming your hard drive mounted in /media, like /media/usb0, /media/usb0
    ./run.sh -m /media -b /home/pi/lomo -h 192.168.1.232 -s 192.168.1.0/24 -g 192.168.1.1 -n eth0 -a 192.168.1.99
```

您可以将运行命令添加到"/etc/rc.local"中，在"exit 0"之前，这样系统开机的时候就可以自动启动了。

## APT安装

如果您运行官方的系统，APT是最快捷的安装方式。

### 1. 添加lomoware源

```
sudo apt install -y ca-certificates python-certifi python3-certifi
sudo update-ca-certificates --fresh
wget -qO - https://raw.githubusercontent.com/lomoware/lomoware.github.io/master/debian/gpg.key | sudo apt-key add -
```

如果您使用 jessie:

```
echo "deb https://lomoware.github.io/debian/jessie jessie main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用buster:

```
echo "deb https://lomoware.github.io/debian/buster buster main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

然后运行:

```
sudo apt update
```

### 2. 安装Lomorage

最小安装需要lomo-vips和lomo-backend，您可以根据自己需要进行选择。

- lomo-backend: 必须, Lomorage服务程序

- lomo-web: 可选, Lomorage网页程序

- lomo-base: 可选, 系统工具，包括网络配置，开关控制, 磁盘加载, 蓝牙控制台

- lomo-vips: 必须, lomo-backend使用的图像处理库

- lomo-frame: 可选, 数码相框程序

```
sudo apt install lomo-base lomo-vips lomo-backend lomo-web lomo-frame -y
```

### 3. 按需修改加载目录

如果您不是使用步骤4的usbmount来自动加载磁盘（没有加载到"/media"路径下的子目录），您需要添加Lomorage服务程序运行参数来指定加载目录。

比如如果您使用PCManFM，那么加载的路径会是"/media/pi"。 要指定加载目录"/media/pi", 修改"/lib/systemd/system/lomod.service"的`ExecStart`字段，加上  "--mount-dir"参数:

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir /media/pi  --max-upload 1 --max-fetch-preview 3
```

**请确保您的用户有上面设置的"mount-dir"的读写权限**

### 4. 运行

重启Lomorage服务程序:

```
# 重启lomo-backend
sudo systemctl restart lomod

# 重启lomo-web
sudo systemctl restart lomow

# 重启lomo-frame
sudo service supervisor restart
```
