+++
title = "迁移MyCloud的数据到Lomorage"
tags = ["迁移", "MyCloud"]
categories = ["BLOG"]
date = "2020-05-17T13:43:40"
banner = "/img/blog/import_my_cloud/banner_mycloud_lomo.png"
+++

  **曾经**买了一个WD-西部数据的MyCloud 6T的存储，用来存照片和视频。因为它的App不好用，
所以每次都是用USB线把手机连上电脑，然后开着电脑把手机的照片拷贝到MyCloud的共享盘里。
下面我们来看看如何把MyCloud的东西迁移到Lomorage。

<!--more--> 


目录
=================

   * [配置您的MyCloud](#配置您的MyCloud)
      * [1. 打开MyCloud的SSH访问](#1-打开MyCloud的SSH访问)
      * [2. 用SSH连上MyCloud](#2-用SSH连上MyCloud)
      * [3. 编辑exports文件](#3-编辑exports文件)
   * [加载MyCloud的目录到Lomorage上](#加载MyCloud的目录到Lomorage上)
      * [1. 用SSH客户端连上Lomorage服务器](#1-用SSH客户端连上Lomorage服务器)
      * [2. 加载MyCloud目录](#2-加载MyCloud目录)
      * [3. 查看MyCloud文件](#3-查看MyCloud文件)
   * [开始导入MyCloud到Lomorage](#开始导入MyCloud到Lomorage)
      * [1. 扫描文件信息 ](#1-扫描文件信息 )
      * [2. 安装tmux](#2-安装tmux)
      * [3. 开始导入到Lomorage](#3-开始导入到Lomorage)


# 配置您的MyCloud

## 1. 打开MyCloud的SSH访问

打开MyCloud的管理页面，在设置页面，打开SSH，并且按照提示设置密码。如下图：

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/import_my_cloud/f14b9c18-f941-429a-a848-1426f547ab37.png">
</p>
</div>

## 2. 用SSH连上MyCloud

通过SSH 客户端，可以选用putty，用SSH连上MyCloud。

操作命令如下：

> ssh -oHostKeyAlgorithms=+ssh-dss root@192.168.0.24


进入 nfs目录，查看你的共享目录有哪些。比如我的共享目录有如下图所示：

> cd /nfs 

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/import_my_cloud/6822a363-9172-4e35-b77c-5318ea01c50a.png">
</p>
</div>

其中 **Public** 是我想要Mount到Lomorage的目录。

## 3. 编辑exports文件

在SSH 客户端运行如下命令：

> sudo vi /etc/exports

然后黏贴如下的一行：

> /nfs/Public 192.168.0.1/24(rw,subtree_check,secure)

如下图：

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/import_my_cloud/ad38c19b-10b1-4b82-92ec-68b6f2481601-1.png">
</p>
</div>


其中 **192.168.0.1** 是你的路由器的地址, **请做相应的改动！**

然后 保存 退出。如果对VI不熟悉的，可以自行google或者百度。
或者在本站联系Lomorage支持。
到此为止，MyCloud的配置算是完成了。

# 加载MyCloud的目录到Lomorage上

## 1. 用SSH客户端连上Lomorage服务器

在SSH客户端里，运行如下命令：

> ssh pi@192.168.0.40

pi 用户的默认密码是 raspberry

## 2. 加载MyCloud目录

新建一个目录：

> cd /home/pi 
> 
> sudo mkdir mycloud


运行以下命令加载MyCloud的目录

> sudo mount 192.168.0.24:/nfs/Public /home/pi/mycloud

**192.168.0.24** 是前面步骤里MyCloud的IP地址，此处应改成你的MyCloud的IP地址。


如果上述命令有错误输出，请输入：

> sudo rpcbind start

然后再重复 第一个命令: 

> sudo mount 192.168.0.24:/nfs/Public /home/pi/mycloud

## 3. 查看MyCloud文件

> cd /home/pi/mycloud

这里你就可以看到MyCloud上的文件了。恭喜你，关键步骤成功了！！

# 开始导入MyCloud到Lomorage

## 1. 扫描文件信息 

运行如下命令扫描你mount的目录

> cd /opt/lomorage/bin

> ./lomoc s /home/pi/mycloud    
    
[mycloud 是你mount过来的MyCloud（西部数据磁盘）的目录]


如果照片视频多的话，这个过程可能需要花点时间。

扫描完之后，可以进入 

> ~/.lomo 

来看看您有哪些是没有被分类的，因为有些照片和视频没有时间信息。
比如下面的图：

~~~
pi@raspberrypi-lomorage:~/.lomo/links/unclassfied $ ls -l
total 20
drwxr-xr-x 2 pi pi 4096 May 17 16:42  aisnote
drwxr-xr-x 6 pi pi 4096 May 17 16:42  mydoc
drwxr-xr-x 4 pi pi 4096 May 17 16:42  myphone
drwxr-xr-x 9 pi pi 4096 May 17 16:42 'Shared Pictures'
drwxr-xr-x 6 pi pi 4096 May 17 16:42 'Shared Videos'
pi@raspberrypi-lomorage:~/.lomo/links/unclassfied $ cd 'Shared Pictures'/
pi@raspberrypi-lomorage:~/.lomo/links/unclassfied/Shared Pictures $ ls -l
total 28
drwxr-xr-x  3 pi pi 4096 May 17 16:42 2015
drwxr-xr-x  3 pi pi 4096 May 17 16:42 2016
drwxr-xr-x 15 pi pi 4096 May 17 16:42 2017
drwxr-xr-x 13 pi pi 4096 May 17 16:42 2018
drwxr-xr-x 13 pi pi 4096 May 17 16:42 2019
drwxr-xr-x  2 pi pi 4096 May 17 16:42 xiaomi
drwxr-xr-x  2 pi pi 4096 May 17 16:42 来自：iPhone
pi@raspberrypi-lomorage:~/.lomo/links/unclassfied/Shared Pictures $
~~~

## 2. 安装tmux
这一个步骤对于熟练使用Linux的人，可以忽略。

因为SSH登录linux，运行某个命令，如果你关闭了SSH 客户端，那个命令就退出了。
为了让导入工作持续在Lomorage服务器上运行，建议运行如下命令安装 tmux，可以google或者baidu一下如何使用tmux。
[点这里有个简单的教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)


> sudo apt install tmux

然后

> tmux


## 3. 开始导入到Lomorage

此时，已经进入 tmux 会话，运行如下命令：

> cd /opt/lomorage/bin

> ./lomoc import -y [lomorage username] [password]

**请注意**： 这里的username 和 password 是你手机APP登录Lomorage的用户名。

接下来，lomoc 程序会发现当前网络下有多少个Lomorage的服务器，按照提示选择。

开始导入的信息会打印输出到屏幕，像下面的一样：

~~~
success upload /home/pi/.lomo/links/classfied/2010/09/16/Does a Kangaroo Have a Mother, Too_ Book Read Aloud, written by Eric Carle.mp4
success upload /home/pi/.lomo/links/classfied/2010/10/07/If the Dinosaurs Came Back.m4v.mp4
success upload /home/pi/.lomo/links/classfied/2010/10/25/Click, Clack, Moo Cows That Type by - Doreen Cronin.mp4
~~~


# 后记
  
  **Lomorage会提供新的API，未来这个导入过程将可以在手机APP上进行，待续！**











