---
title: Raspbian
weight: 1
---

# 在树莓派上安装"Lomorage照片助手"程序

要在树莓派上运行，您需要先购买一个[树莓派](https://www.raspberrypi.org/)，Lomorage可以运行在以下型号的机器上:

- [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

如果您还没有树莓派，我们建议购买新款的树莓派，会有更好的性能。下面是您需要的最小配置:

- 树莓派主板
- 配套电源
- 16GB MicroSD卡

**有3种方式来在Raspberry Pi上安装"Lomorage照片助手"程序**, 一种是安装预编译好的系统镜像，该镜像已经安装了所有"Lomorage照片助手"程序依赖的库和第三方工具，简单快捷，推荐使用；如果您已经有树莓派在运行其他服务，您也可以使用Docker镜像来安装，或者使用从APT源安装。

## 安装系统镜像

预装的系统镜像包括所有的包:

- lomo-backend: "Lomorage照片助手"程序

- lomo-base: 系统工具，包括网络配置，开关控制, 磁盘加载, 蓝牙控制台

- lomo-frame: 数码相框程序

点击下面的链接下载系统镜像。

<p align="center">
<a href="https://gfw.lomorage.com/https://github.com/lomorage/pi-gen/releases/download/2021_11_05.23_32_53.0.4a997ab/image_2021-11-05-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

下载了系统镜像后, 你可以使用[balenaEtcher](https://www.balena.io/etcher/)将其安装到MicroSD卡, balenaEtcher提供Windows和macOS版本。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>
</div>

将MicroSD卡插入到台式电脑或笔记本的读卡器后，选择下载的系统镜像，选择MicroSD卡，点击“Flash“按钮，几分钟后工具就会提示您的MicroSD卡已经就绪, 之后将**MicroSD卡插入到树莓派，接上USB移动硬盘，插入网线，接通电源，等待几分钟系统启动完毕，您就可以用Lomorage 手机App开始备份照片了**。

如果您连接了HDMI，系统启动完成后，会提示没有找到资源，也会显示一个二维码用来绑定Lomorage相框，**请先在iOS/Android手机应用上创建用户，然后再扫码绑定Lomorage相框**，您可以使用Lomorage手机应用程序上传照片，然后按"r"键重新扫描。如果您想退出到控制台做一些系统配置，可以按"ESC"退出，然后按"Ctrl+Alt+F2"切换到控制台，配置完成后，可以使用命令`sudo service supervisor restart`来启动Lomorage相框程序。

*默认的用户名是"lomoware"，密码是"lomorage"*

为了更好的性能，建议使用有线网络连接，但如果您想使用WiFi, 您可以登陆树莓派，并使用下面的命令来启用无线连接`wifi_switch.sh client wifi-ssid wifi-password`，将 "wifi-ssid"和"wifi-password"替换为您的无线网络名和密码。*如果您的无线网络名称中有中文字符或者空格，就需要用引号，比如`wifi_switch.sh client "Lomorage的 无线" mypassword`*

{{< hint warning >}}
您有可能会碰到"Wi-Fi is currently blocked by rfkill"的问题，可以执行下面的命令检查一下WiFi是否被禁用:

```
pi@raspberrypi:~ $ sudo rfkill list all
0: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no
1: hci0: Bluetooth
	Soft blocked: yes
	Hard blocked: no
```

您可以使用下面的命令来启用WiFi:

```
sudo rfkill unblock 0
```

这里“0”是上面Wireless LAN的序号。

启用之后您可以再尝试`wifi_switch.sh`。

{{< /hint >}}

# 其他安装方法
## 选项一：Docker安装

请参考[lomo-docker](https://github.com/lomorage/lomo-docker)安装Docker镜像。请使用arm的镜像"lomorage/raspberrypi-lomorage:latest"。

## 选项二：APT安装

如果您运行官方的系统，APT是最快捷的安装方式。

### 1. 添加lomoware源

```bash
sudo apt install -y ca-certificates python3-certifi
sudo update-ca-certificates --fresh
curl -fsSL https://lomoware.lomorage.com/debian/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/lomorage-apt-key.gpg > /dev/null

```

如果您使用trixie:

```bash
echo "deb https://lomoware.lomorage.com/debian/trixie trixie main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用bookworm:

```bash
echo "deb https://lomoware.lomorage.com/debian/bookworm bookworm main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用bullseye:

```bash
echo "deb https://lomoware.lomorage.com/debian/bullseye bullseye main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

然后运行:

```bash
sudo apt update
```

### 2. 安装Lomorage

最小安装需要lomo-vips和lomo-backend，您可以根据自己需要进行选择。

- lomo-backend: 必须, "Lomorage照片助手"程序

- lomo-base: 可选, 系统工具，包括网络配置，开关控制, 磁盘加载, 蓝牙控制台

- lomo-vips: 必须, lomo-backend使用的图像处理库

- lomo-frame: 可选, 数码相框程序

```bash
sudo apt install lomo-base lomo-vips lomo-backend lomo-frame -y
```

确保当前用户sudo不用密码, 如果不行，可以通过下面的命令添加:

```bash
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

### 3. 按需修改运行参数

用户可以在"/opt/lomorage/etc/environment"设置环境变量来修改某些运行参数。用户可以根据自己实际情况加以调整。

#### 3.1 修改磁盘mount目录

如果您不是使用步骤4的usbmount来自动加载磁盘（没有加载到"/media"路径下的子目录），您需要添加"Lomorage照片助手"程序运行参数来指定加载目录。

比如如果您使用PCManFM，那么加载的路径会是"/media/pi"。 要指定加载目录"/media/pi", 请添加环境变量`LOMOD_MOUNT_DIR=/media/pi`在`/opt/lomorage/etc/environment`，比如

```
echo "LOMOD_MOUNT_DIR=/media/pi" | tee -a /opt/lomorage/etc/environment
```

**请确保您的用户有上面设置的"mount-dir"的读写权限, 另外改参数必须是mount的父目录，比如mount到"/media/pi/disk0"下面，就必须指定为"/media/pi"**

另外的方案是`cp /lib/systemd/system/lomod.service /etc/systemd/system/lomod.service`，然后编辑"/etc/systemd/system/lomod.service"，修改"ExecStart"指定要用的参数(运行`/opt/lomorage/bin/lomod -h`查看可用的参数)，然后运行`sudo systemctl daemon-reload`之后，就会使用"/etc/systemd/system/lomod.service"的配置了。 "/lib/systemd/system/lomod.service"在升级时会被覆盖。

#### 3.2 HTTP 监听端口

Lomod缺省监听端口是8000，如果需要自定义，清使用环境变量`LOMOD_PORT_HTTP`，比如

```
echo "LOMOD_PORT_HTTP=8888" | tee -a /opt/lomorage/etc/environment
```

#### 3.3 禁用磁盘监控

Lomod会监控USB磁盘的加载状态，防止掉盘。如果因为某些原因需要禁用，可以使用环境变量`LOMOD_DISABLE_MOUNT_MONITOR`控制，比如

```
echo "LOMOD_DISABLE_MOUNT_MONITOR=1" | tee -a /opt/lomorage/etc/environment
```

### 4. 运行

重启"Lomorage照片助手"程序:

```bash
# 重启lomo-backend
sudo systemctl restart lomod

# 重启lomo-frame
sudo service supervisor restart
```
