+++
title = "手机照片自动备份到群晖 NAS、Unraid 或 Docker 服务器"
description = "用 Lomorage 把 iPhone 和安卓照片自动备份到群晖 NAS、Unraid 或任意 Docker 主机：安装步骤、目录规划和使用技巧。"
tags = ["NAS", "群晖", "Docker", "Unraid", "照片备份"]
categories = ["教程"]
date = "2026-11-24"
banner = "/img/home/mountains.jpg"
related = ["google-photos-alternative", "321-backup-family-photos", "windows-docker"]

[[faq]]
q = "不用 Synology Photos，能把 iPhone 照片备份到群晖吗？"
a = "可以。Lomorage 以 Docker 容器的形式运行在群晖上，LomoMobile App 通过家庭网络把 iPhone 和安卓照片备份过去。"

[[faq]]
q = "照片存在 NAS 的哪里？"
a = "存在你挂载为容器 /media 目录的文件夹里。照片是普通文件，用 NAS 自带的工具也能直接访问。"

[[faq]]
q = "有了 NAS 还需要其他备份吗？"
a = "需要。NAS 即使做了 RAID，也只是一个地点的一台设备。无可替代的照片请再保留一份独立副本，最好放在异地。"
+++

NAS 本来就 24 小时开机、空间充足、又在家庭网络里——是存放全家照片备份的理想位置。本文介绍如何在**群晖 NAS、Unraid 或任意 Docker 主机**上运行 Lomorage，让家里每部手机都能自动备份。

<!--more-->

## 为什么把照片备份放在 NAS 上

- **一直在线。** 手机可以在夜里备份，不用让电脑一直开着。
- **空间可扩展。** 图库变大时，加盘或换盘即可。
- **全家共用。** 每人一个账号，都备份到同一个地方。
- **普通文件。** 照片以普通文件存放在你指定的文件夹，不会被锁在某个 App 的数据库里。

## 准备工作

- 带 Container Manager（Docker）的群晖 NAS、Unraid 服务器，或任意装有 Docker 的 Linux 机器（amd64 或 arm）。
- 装有 LomoMobile 的 iPhone 或安卓手机。
- 设置时手机和 NAS 在同一家庭网络。

## 群晖：简要步骤

1. 在 **Container Manager / Docker** 的注册表中搜索 `lomorage`，按 NAS 的架构（arm 或 amd64）下载镜像。
2. 启动容器，并勾选**自动重启**。
3. 创建 `docker/lomorage` 文件夹，包含两个子文件夹：
   - `data` → 挂载到 `/media`（照片和视频）
   - `app` → 挂载到 `/lomo`（配置和日志）
4. 添加 TCP 端口映射 `8000 → 8000`，点击**应用**启动容器。
5. 在手机上安装 LomoMobile，连接家里的 Wi-Fi，添加服务器。使用默认的 bridge 网络时需要手动输入 NAS 的 IP 地址；配置 macvlan 网络后，App 可以自动发现服务器。

带截图的完整步骤见[群晖安装指南](/zh/docs/Installation/lomorage-service/installation-synology/)。

## Unraid 和通用 Docker

- **Unraid：** 参考 [Unraid 安装指南](/zh/docs/Installation/lomorage-service/installation-unraid/)。
- **Linux、Windows 或其他 NAS 上的 Docker：** 参考 [Docker 安装指南](/zh/docs/Installation/lomorage-service/installation-docker/)。Windows 用户也可以看看[在 Windows 10 上安装 Lomorage 容器镜像](/zh/blog/2020/11/16/windows-docker/)。

树莓派、Ubuntu、OpenWrt 等其他平台，见[选择电脑或家庭服务器](/zh/docs/Installation/lomorage-service/)。

## 手机端小技巧

- **首次备份：** 保持 LomoMobile 打开并给手机充电。手机系统会限制后台活动，iPhone 尤其明显。
- **备份时机：** 首次同步后，可选择仅 Wi-Fi、仅充电或夜间备份。
- **选择文件夹：** 在安卓上，可选择要备份的文件夹（相机、截图、聊天软件等）。
- **家人账号：** 为每位家人创建账号，让他们扫码登录。

## 导入已有照片

如果 NAS 或旧硬盘上已经有多年的照片，可以用 [Lomorage 导入工具](/zh/docs/Installation/lomorage-importer/)导入，所有照片都能在一个地方搜索。从 WD MyCloud 迁移？参考[迁移 MyCloud 的数据到 Lomorage](/zh/blog/2020/05/17/import_my_cloud/)。

## 在外面访问

在家庭网络以外查看原图，需要使用内网穿透服务或在路由器上做端口映射。参考[外网访问](/zh/docs/Usage/external-access/)。

## RAID 不是备份

镜像盘能防一块硬盘损坏，但防不了误删、勒索病毒或灾害。请为 NAS 再配一份放在别处的副本——见[家庭照片 3-2-1 备份原则](/zh/blog/2026/11/24/321-backup-family-photos/)。

准备好了？[下载 LomoMobile](/zh/#download)，连上你的 NAS。
