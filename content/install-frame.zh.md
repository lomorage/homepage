目录
=================

   * [安装lomo-frame](#安装lomo-frame)
   * [配置lomo-frame](#配置lomo-frame)
      * [快速开始](#快速开始)
      * [关闭开启相框](#关闭开启相框)
      * [关闭开启lomo-frame应用](#关闭开启lomo-frame应用)
      * [定时开关](#定时开关)
      * [播放顺序](#播放顺序)
      * [自定义播放列表](#自定义播放列表)
      * [播放媒体类型](#播放媒体类型)
      * [快捷键](#快捷键)
      * [设置多个数码相框](#设置多个数码相框)
         * [1. 安装lomo-frame](#1-安装lomo-frame)
         * [2. 设置WiFi连接](#2-设置wifi连接)
         * [3. 检查主树莓派的IP地址](#3-检查主树莓派的ip地址)
         * [4. 找到主树莓派的加载目录](#4-找到主树莓派的加载目录)
         * [5. 远程挂载媒体目录到树莓派zero w](#5-远程挂载媒体目录到树莓派zero-w)
         * [6. 重启](#6-重启)

# 安装lomo-frame

**如果您使用最新的Lomorage树莓派系统镜像, 就无需再安装lomo-frame应用，已经预装到系统中了**

否则，如果您的系统镜像是2020-03-13之前的 ("image_2020-03-13-lomorage-lite.zip
")，或者您没有使用Lomorage树莓派系统镜像，您可以使用下面的命令安装（您应该已经安装过lomorage服务程序，添加过"gpg.key"文件，如果没有，请参考[这里](/zh/installation-pi)）。

```
sudo apt update
sudo apt install lomo-frame
```

# 配置lomo-frame

**Lomorage电子相框程序还是beta版本，您可能需要连接键盘到树莓派，或者通过ssh方式访问树莓派。未来我们会支持通过手机方式来控制相框程序。**

## 快速开始

如果您已经安装了lomo-frame程序，它会在开机后自动启动。

第一次启动时，它会扫描"/media"目录下面的照片和视频文件，并生成播放列表放在"/opt/lomorage/var/lomo-playlist.txt"文件中。

**系统会在每周重现扫描一次(周日00:00)**, 来更新播放列表。您也可以手动来触发重新扫描，有两种方式:

1. 如果您的树莓派连接了键盘，可以按"r"键重新扫描。

2. 如果您使用ssh访问，可以使用`framectrl.sh rescan`命令来重新扫描.

## 关闭开启相框

lomo-frame应用程序会在系统启动的时候自动加载，但如果您需要手动控制，你可以使用`framectrl.sh on`命令打开, 或者使用`framectrl.sh off`命令关闭。**这个命令打开或关闭lomo-frame应用，并同时打开或者关闭显示器。**

## 关闭开启lomo-frame应用

如果您只是想退出lomo-frame应用，但是想让显示器继续开着，您可以使用下面的方法之一:

 - 如果树莓派接了键盘，按"esc"键。

 - 如果您使用ssh访问，使用`sudo service supervisor stop`命令。

您可以用`sudo service supervisor start`命令打开lomo-frame应用.

## 定时开关

**默认打开时间是"08:00 am", 关闭时间是"21:00 pm".**

您可以使用下面的命令来修改, 下面的命令修改打开时间为"10:00 am"，关闭时间为"18:00":

```
framectr.sh add --on-hour 10 --off-hour 18
```

您也可以修改打开时间为"10:30 am"，关闭时间为"18:30"

```
framectr.sh add --on-hour 10 --on-min 30 --off-hour 18 --off-min 30
```

或者您想7x24小时开机, 删除定时开关机:

```
framectr.sh remove
```

## 播放顺序

**默认是随机播放**，但如果您希望顺序播放:

```
sudo sed -i "s/is_random =.*/is_random = false/" /opt/lomorage/var/video_looper.ini
```

或者您想改为随机播放:

```
sudo sed -i "s/is_random =.*/is_random = true/" /opt/lomorage/var/video_looper.ini
```

## 自定义播放列表

您可以创建后修改播放列表文件"/opt/lomorage/var/lomo-playlist.txt"，格式是每个文件路径一行。

## 播放媒体类型

**默认会播放视频和照片**，但如果您只想播放照片，您可以修改"/opt/lomorage/var/video_looper.ini"文件中的"media_type":

```
sudo sed -i "s/media_type =.*/media_type = image/" /opt/lomorage/var/video_looper.ini
```

或者您只想播放视频:

```
sudo sed -i "s/media_type =.*/media_type = video/" /opt/lomorage/var/video_looper.ini
```

或者想重置为播放视频和照片:

```
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

如果您已经有了树莓派再跑Lomorage服务程序（主树莓派），并在上面连接了移动硬盘，您很可能会把它放在储藏室并使用有线连接，而您可能是希望数码相框放在卧室或者客厅。

您可以使用低成本的树莓派Zero w来安装数码相框程序，并通过WiFi远程访问您的照片和视频。树莓派Zero w跑数码相框应用甚至能流畅的播放视频。

### 1. 安装lomo-frame

您可以按照本页面最前面的方式来安装。

### 2. 设置WiFi连接

键盘连接到Raspberry Pi zero W并登陆, 如果您是Lomorage的树莓派镜像，可以使用命令`wifi_switch client [wifi-ssid] [wifi-password]`, 用您自己的配置替换"[wifi-ssid]"和"[wifi-password]"。如果使用其他系统，您可以参考网上其他资料来设置WiFi连接。

### 3. 检查主树莓派的IP地址

您可以在手机APP里面查看，点击“设置”，找到“本地服务”，其中的"服务器地址“字段里面的就是IP地址。

### 4. 找到主树莓派的加载目录

您可以把主树莓派的"media"目录通过SAMBA协议加载到电脑上，用户名是"pi"，密码是"raspberry"，你可以在"media"目录下找到加载的存储媒体文件的目录名。

### 5. 远程挂载媒体目录到树莓派zero w

比如加载到主树莓派的目录路径为"/media/WD_90C27F73C27F5C82"，主树莓派的IP地址为192.168.1.155, 您可以登陆树莓派zero w，并远程挂载那个目录到本地:

```
sudo mkdir /media/WD_90C27F73C27F5C82
echo "//192.168.1.124/media/WD_90C27F73C27F5C82  /media/WD_90C27F73C27F5C82  cifs  user=pi,pass=raspberry,uid=1000,gid=1000" | sudo tee -a /etc/fstab
sudo mount -a
```

### 6. 重启

```
sudo reboot
```

重启之后，您应该可以看到开始扫描媒体文件，并生成播放列表了。