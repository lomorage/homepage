---
title: 群晖
weight: 6
---

# 群晖

## 1. 从docker镜像仓库里面搜索lomorage

找到lomorage镜像文件后，单击`Download`图标，下载docker文件。注意lomorage有arm和amd64的不同版本，请根据您的实际情况，下载对应的docker文件

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology1.png">
</p>

## 2. 启动lomorage镜像

在Image页面，选择已经下载的lomorage container，点击`Launch`图标

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology2.png">
</p>

## 3. 高级设置

设置container名字，然后点击`Advanced Setting`图标

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology3.png">
</p>

### 3.1. 勾选自动重启

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology4.png">
</p>

### 3.2. 设置Volume

在volume页面，点击`Add Folder`，添加lomorage文件夹和两个子文件夹:
 - data: 这个文件夹主要用来存储图片和视频文件, 需要mount到container内部`/media`目录
 - app:  这个文件夹主要用来存储应用相关的log，配置文件等等，需要mount到container内部`/lomo`

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology5.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology6.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology7.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology8.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology9.png">
</p>

### 3.3. 设置端口

在端口设置页面，添加tcp端口映射8000 -> 8000

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology10.png">
</p>

## 4. Done

点击 `Apply` 按钮，lomorage container应当开始运行，你可以从手机端访问"Lomorage照片助手"

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology11.png">
</p>

## 5. 高级MAC vlan docker 网络

上述步骤使用缺省的docker bridge网络，用户需要在手机端手动输入ip和端口。如果用户对ssh和docker命令有些了解，可以通过添加docker mac vlan网络的方式来启用MDNS功能，这样手机端就可以自动发现"Lomorage照片助手"。首先需要确认你知道自己的子网，网关ip，网络接口名字，lomorage container分配的新的静态ip，以下截图假设
 - subnet: 192.168.1.0/24
 - gateway: 192.168.1.1
 - interface name: eth0
 - new static ip: 192.168.1.100

使用SSH登陆群晖, 运行 `docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 --ip-range=192.168.1.100/32 -o parent=eth0 lomorage`生成新的网络.

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology12.png">
</p>

在群晖 docker的网页中，从侧边栏中点击`Network`，应该可以看到新的`lomorage`网络选项

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology13.png">
</p>

停止运行的lomorage container，点击`Edit`按钮，在`Network`页面，添加新的`lomorage`，并且删除旧的`bridge`网络，点击Apply，重新启动container，现在手机端应该可以自动发现后端应用了

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/synology14.png">
</p>
