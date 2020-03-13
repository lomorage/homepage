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

**有两种方式来在Raspberry Pi上安装Lomorage服务程序**，一种是安装预编译好的系统镜像，该镜像已经安装了所有Lomorage服务程序依赖的库和第三方工具，简单快捷，推荐使用；另一种方式相对繁琐一点，但如果您已经有Raspberry Pi在运行其他的服务程序，您可以选择这种安装方式。

## 安装系统镜像

点击下面的链接下载系统镜像。

<p align="center">
<a href="https://github.com/lomorage/pi-gen/releases/download/2019_09_26.21_07_53.0.0cbe0a8/image_2019-09-26-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

下载了系统镜像后, 你可以使用[balenaEtcher](https://www.balena.io/etcher/)将其安装到MicroSD卡, balenaEtcher提供Windows和macOS版本。

将MicroSD卡插入到台式电脑或笔记本的读卡器后，选择下载的系统镜像，选择MicroSD卡，点击“Flash“按钮，几分钟后就会安装完成。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>
</div>

安装完后，将MicroSD卡插入到树莓派，接上USB移动硬盘，插入网线，接通电源，等待几分钟系统启动。

为了更好的性能，我们强烈建议使用有线网络连接，但如果您想使用WiFi, 您可以登陆树莓派，并使用下面的命令来启用无线连接`wifi_switch client [wifi-ssid] [wifi-password]`，将 "[wifi-ssid]"和"[wifi-password]"替换为您的无线网络名和密码。

*登陆的用户名是"pi"，密码是"raspberry"*

## 安装在已有的Raspbian系统上

**步骤1. 添加lomoware源**

```
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

**步骤2. 安装第三方工具**

```
sudo apt install ffmpeg rsync jq libimage-exiftool-perl -y
```

**步骤3. 安装文件系统支持**

```
sudo apt install nfs-common exfat-fuse ntfs-3g hfsplus hfsutils hfsprogs -y
sudo ln -nsf /bin/ntfsfix /sbin/fsck.ntfs
sudo ln -nsf /bin/ntfsfix /sbin/fsck.ntfs-3g
```

**步骤4. 安装usbmount**

如果您在使用桌面系统，因为已经有PCManFM可以自动加载USB磁盘，您可以跳过这一步。如果您使用的是Lite系统镜像，您可以使用usbmount来自动加载USB磁盘。

我们使用的usbmount是一个修改过的版本，保证特定的磁盘设备加载到"/media"路径下面特定的子目录下，不会因为设备接入顺序不同而加载到不同的目录。

```
sudo apt install lockfile-progs -y
sudo mkdir /etc/usbmount
sudo mkdir /usr/share/usbmount
sudo wget -qO /etc/usbmount/usbmount.conf https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount.conf
sudo wget -qO /usr/share/usbmount/usbmount https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount
sudo chmod +x /usr/share/usbmount/usbmount
sudo wget -qO /etc/udev/rules.d/usbmount.rules https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount.rules
sudo wget -qO /etc/systemd/system/usbmount@.service https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount%40.service
```

**步骤5. 安装Lomorage服务应用**

```
sudo apt install lomo-vips lomo-backend -y
```

**步骤6. 按需修改加载目录**

如果您不是使用步骤4的usbmount来自动加载磁盘（没有加载到"/media"路径下的子目录），您需要添加Lomorage服务程序运行参数来指定加载目录。比如如果您使用PCManFM，那么加载的路径会是"/media/pi"。

要指定加载目录"/media/pi", 修改"lib/systemd/system/lomod.service" `ExecStart`字段，加上  "--mount-dir"参数:

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir /media/pi  --max-upload 1 --max-fetch-preview 3
```

重启Lomorage服务程序:

```
sudo systemctl restart lomod
```
