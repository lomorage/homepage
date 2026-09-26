---
title: Lomorage相框
weight: 12
---

# 安装

{{< hint warning >}}
Lomo-frame应用只支持Raspberry Pi平台, Windows/Mac或docker版本不支持。
{{< /hint >}}

如果您使用最新的Lomorage树莓派系统镜像, 就无需再安装Lomo-frame应用，已经预装到系统中了。

如果您没有使用Lomorage树莓派系统镜像，请参考[这里](/zh/docs/Installation/lomorage-service/installation-raspbian/#1-%e6%b7%bb%e5%8a%a0lomoware%e6%ba%90)添加lomoware的源，您可以使用下面的命令安装:

```bash
sudo apt update
sudo apt install lomo-frame
```

# 配置

您有多个选择:

1. 在同一个树莓派上运行"Lomorage照片助手"和相框程序。

2. 在不同的树莓派上运行"Lomorage照片助手"和相框程序，比如您可以用树莓派zero来运行相框程序，用性能更好的的树莓派4来运行树莓派4。

如果相框程序运行起来后，会在相框屏幕上显示一个二维码，您可以使用iOS 或者 安卓 Lomorage应用程序来注册相框，成功后，您就可以在Lomorage手机应用里给相框分享照片了，就像分享到其他联系人一样。

## 快速开始

如果您已经安装了Lomo-frame程序，它会在开机后自动启动。

如果树莓派没有连上网络，您需要先将其连上网络，如果您使用WiFi，先连上HDMI和键盘，然后重启设备，按照屏幕上的提示进入命令行并登陆，接下来可以使用命令`wifi_switch.sh client [wifi-ssid] [wifi-password]`, 用您自己的配置替换"[wifi-ssid]"和"[wifi-password]"。

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

网络设置完成后，重启，会显示QRCode，您可以到Lomorage iOS APP的设置页面，注册相框，然后您就可以使用手机应用程序来分享照片给数码相框。

<div align="center">
<p class="screenshoot">
  <img width="30%" src="/img/installation/frame-register-ios.png">
  <img width="30%" src="/img/installation/frame-share-ios.png">
</p>
</div>

如果你无需更多的高级配置，则可以跳过下面的内容。

## 关闭开启相框

Lomo-frame应用程序会在系统启动的时候自动加载，但如果您需要手动控制，你可以使用`framectrl.sh on`命令打开, 或者使用`framectrl.sh off`命令关闭。**这个命令打开或关闭Lomo-frame应用，并同时打开或者关闭显示器。**

## 关闭开启Lomo-frame应用

如果您只是想退出Lomo-frame应用，但是想让显示器L续开着，您可以使用下面的方法之一:

 - 如果树莓派接了键盘，按"esc"键。

 - 如果您使用ssh访问，使用`sudo service supervisor stop`命令。

您可以用`sudo service supervisor start`命令打开Lomo-frame应用.

## 定时开关

**默认打开时间是"08:00 am", 关闭时间是"21:00 pm".**

您可以使用下面的命令来修改, 下面的命令修改打开时间为"10:00 am"，关闭时间为"18:00":

```bash
framectr.sh add --on-hour 10 --off-hour 18
```

您也可以修改打开时间为"10:30 am"，关闭时间为"18:30"

```bash
framectr.sh add --on-hour 10 --on-min 30 --off-hour 18 --off-min 30
```

或者您想7x24小时开机, 删除定时开关机:

```bash
framectr.sh remove
```

## 播放顺序

**默认是随机播放**，但如果您希望顺序播放:

```bash
sudo sed -i "s/is_random =.*/is_random = false/" /opt/lomorage/var/video_looper.ini
```

或者您想改为随机播放:

```bash
sudo sed -i "s/is_random =.*/is_random = true/" /opt/lomorage/var/video_looper.ini
```

## 自定义播放列表

您可以创建后修改播放列表文件"/opt/lomorage/var/lomo-playlist.txt"，格式是每个文件路径一行。

## 播放媒体类型

**默认会播放视频和照片**，但如果您只想播放照片，您可以修改"/opt/lomorage/var/video_looper.ini"文件中的"media_type":

```bash
sudo sed -i "s/media_type =.*/media_type = image/" /opt/lomorage/var/video_looper.ini
```

或者您只想播放视频:

```bash
sudo sed -i "s/media_type =.*/media_type = video/" /opt/lomorage/var/video_looper.ini
```

或者想重置为播放视频和照片:

```bash
sudo sed -i "s/media_type =.*/media_type = all/" /opt/lomorage/var/video_looper.ini
```

## 快捷键

您可以通过下面的快捷键来控制:

  - "r": 重新扫描并生成播放列表。

  - "k": 跳到下一个视频或图片。

  - "s": 暂停播放/继续播放

  - "esc": 退出应用

## 设置多个数码相框

下面的设置需要比较多的专业知识，以后我们会在手机应用中添加相应的控制和配置功能。

如果您已经有了树莓派在跑"Lomorage照片助手"程序（主树莓派），并在上面连接了移动硬盘，您很可能会把它放在储藏室并使用有线连接，而您可能是希望数码相框放在卧室或者客厅。

您可以使用低成本的树莓派Zero w来安装数码相框程序，并通过WiFi远程访问您的照片和视频。树莓派Zero w跑数码相框应用甚至能流畅的播放视频。

- 1. 安装Lomo-frame

您可以按照本页面最前面的方式来安装。

- 2. 设置WiFi连接

键盘连接到Raspberry Pi zero W并登陆, 如果您是Lomorage的树莓派镜像，可以使用命令`wifi_switch.sh client [wifi-ssid] [wifi-password]`, 用您自己的配置替换"[wifi-ssid]"和"[wifi-password]"。如果使用其他系统，您可以参考网上其他资料来设置WiFi连接。

- 3. 检查主树莓派的IP地址

您可以在手机APP里面查看，点击“设置”，找到“本地服务”，其中的"服务器地址“字段里面的就是IP地址。

- 4. 找到主树莓派的加载目录

您可以把主树莓派的"media"目录通过SAMBA协议加载到电脑上，用户名是"lomoware"，密码是"lomorage"，你可以在"media"目录下找到加载的存储媒体文件的目录名。

- 5. 远程挂载媒体目录到树莓派zero w

比如加载到主树莓派的目录路径为"/media/WD_90C27F73C27F5C82"，主树莓派的IP地址为192.168.1.155, 您可以登陆树莓派zero w，并远程挂载那个目录到本地:

```bash
sudo mkdir /media/WD_90C27F73C27F5C82
echo "//192.168.1.124/media/WD_90C27F73C27F5C82  /media/WD_90C27F73C27F5C82  cifs  user=pi,pass=raspberry,uid=1000,gid=1000" | sudo tee -a /etc/fstab
sudo mount -a
```

- 6. 重启

```bash
sudo reboot
```

重启之后，您应该可以看到开始扫描媒体文件，并生成播放列表了。