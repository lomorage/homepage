+++
title = "安卓手机照片如何自动备份到电脑（Windows / Mac）"
description = "通过 Wi-Fi 把安卓手机的照片和视频原图自动备份到 Windows 电脑或 Mac，不用订阅云服务。附详细设置步骤和后台备份技巧。"
tags = ["安卓", "照片备份", "Windows", "Mac", "Lomorage"]
categories = ["教程"]
date = "2026-11-24"
banner = "/img/home/coast.jpg"
related = ["free-up-phone-storage", "backup-iphone-photos-without-icloud", "zero-cost-android-frame"]

[[faq]]
q = "不用云相册，怎么把安卓照片备份到电脑？"
a = "可以用数据线拷贝，也可以安装家庭照片备份软件。使用 Lomorage：在 Windows 电脑或 Mac 上安装免费桌面端，在安卓手机上安装 LomoMobile，扫描设置二维码后，照片就会通过 Wi-Fi 备份。"

[[faq]]
q = "微信图片、截图等文件夹也能备份吗？"
a = "可以。在安卓上可以选择要备份的文件夹，比如相机、截图或聊天软件的文件夹。"

[[faq]]
q = "电脑需要一直开着吗？"
a = "备份时电脑或 NAS 需要开机并能连上。如果希望随时都能备份，可以考虑把 Lomorage 装在一直开机的 NAS 或树莓派上。"
+++

安卓手机拍照很方便，想把照片弄到电脑上却出奇地麻烦：数据线传输会卡住，MTP 很慢，云相册最终还是要你付费。下面教你通过 Wi-Fi 实现**安卓照片自动备份到 Windows 电脑或 Mac**，并保留原画质。

<!--more-->

## 把安卓照片传到电脑的常见方式

**数据线（MTP）：** 插上线，选择“传输文件”，拷贝 DCIM 文件夹。偶尔用一次没问题，但照片多时很慢，容易忘，大视频还常常卡住。

**云同步：** 免费空间用完之前都很方便。但说到底还是在租空间，家里并没有一份副本。

**家庭备份软件：** 运行在你的电脑上，通过 Wi-Fi 自动接收手机照片。下面就来设置它。

## 用 Lomorage 设置自动备份

1. **安装桌面端。** 打开[下载区](/zh/#download)，选择 Windows 或 Mac，复制安装命令并运行。完成后会打开带二维码的设置页。
2. **在安卓手机上安装 LomoMobile**（[安卓安装说明](/zh/docs/Installation/lomorage-client/installation-android/)）。
3. **连接到和电脑相同的 Wi-Fi。**
4. **在 LomoMobile 中扫描设置二维码**，创建账号并选择存储位置。App 会推荐剩余空间最大的硬盘——一块空间充足的移动硬盘最理想。
5. **选择要备份的文件夹**：相机、截图，以及你在意的 App 文件夹（如微信图片）。
6. **选择备份时机**：仅 Wi-Fi、仅充电或夜间。

带截图的详细步骤：[Windows 指南](/zh/docs/Installation/lomorage-service/installation-win/)、[macOS 指南](/zh/docs/Installation/lomorage-service/installation-osx/)。

## 让安卓后台备份更可靠

很多安卓手机为了省电，会主动关闭后台 App。想让备份更稳定：

- **首次大量备份**时保持 LomoMobile 打开。
- 在电池设置中，允许 LomoMobile **不受电池优化限制**（不同品牌叫法不同，如“自启动”“后台高耗电”等）。
- 使用**仅充电**或**夜间**备份，让手机插着电时自动备份。

## 备份之后你能得到什么

- **原始照片和视频**，以普通文件形式存在你自己的硬盘上。
- **AI 搜索**：按场景、人物、地点或图片里的文字搜索——找小票、截图特别方便。
- **释放空间**：删除已备份的大文件（[清理指南](/zh/blog/2026/11/24/free-up-phone-storage/)）。
- **全家可用**：家里的 iPhone 也能备份到同一台电脑（[iPhone 指南](/zh/blog/2026/11/24/backup-iphone-photos-without-icloud/)）。
- **旧平板变相框**：把闲置的安卓平板变成 [Lomorage 电子相框](/zh/blog/2021/08/26/zero-cost-android-frame/)。

## 再存一份

只靠一台电脑，就有单点故障的风险。再加一块硬盘，最好还有一份异地副本——[3-2-1 原则](/zh/blog/2026/11/24/321-backup-family-photos/)讲解了具体做法。

桌面端免费，LomoMobile 一次性购买，不用订阅。[开始第一次备份](/zh/#download)。
