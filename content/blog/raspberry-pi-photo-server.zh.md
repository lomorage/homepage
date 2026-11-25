+++
title = "用树莓派搭建低功耗家庭照片备份服务器"
description = "用树莓派加一块 USB 硬盘，借助 Lomorage 打造全天在线的家庭照片备份服务器：购买清单、安装步骤和稳定运行技巧。"
tags = ["树莓派", "照片备份", "私有云", "Lomorage"]
categories = ["教程"]
date = "2026-11-25"
banner = "/img/blog/raspberrypi-hd/power-hub-adafruit.jpg"
related = ["raspberrypi-hd", "321-backup-family-photos", "external-hard-drive-photo-backup"]

[[faq]]
q = "树莓派性能够用来备份照片吗？"
a = "备份和浏览完全够用。Lomorage 已在树莓派 4B、3B+、Zero W 和 2B 上测试过，新型号性能更好。LomoMobile 的 AI 搜索可以在手机上运行，不需要树莓派承担重活。"

[[faq]]
q = "搭建树莓派照片服务器需要准备什么？"
a = "树莓派主板、稳定的电源、16 GB 以上的 microSD 卡、USB 硬盘，最好再加一个带电源的 USB 分线器和一根网线。"

[[faq]]
q = "如果 microSD 卡坏了，照片会丢吗？"
a = "不会。照片存在硬盘上，数据库也会备份到硬盘。重新烧录系统并恢复数据库即可，具体步骤见 Lomorage 常见问题。"
+++

树莓派只耗几瓦电，可以全年开机，价格比很多云相册一年的费用还低。再接一块 USB 硬盘，就是一台家里每部手机都能用的**全天在线照片备份服务器**。下面介绍如何用 Lomorage 搭建。

<!--more-->

## 为什么选树莓派

- **一直在线、低功耗。** 手机可以在夜里备份，不用开着电脑。
- **便宜。** 一块主板、电源、microSD 卡，再加一块你可能已经有的硬盘。
- **安静小巧。** 放在路由器旁边就行。
- **文件在自己硬盘上。** 照片以普通文件按日期分文件夹保存。

## 购买清单

- **树莓派**——已测试型号包括 4B、3B+、Zero W 和 2B，越新越快。
- **官方或质量可靠的电源。** 供电不足会导致各种奇怪问题。
- **16 GB 以上 microSD 卡。**
- **USB 硬盘**，留足增长空间。
- **带电源的 USB 分线器**——使用 2.5 寸硬盘或多块硬盘时强烈建议。
- **网线**——比 Wi-Fi 更快更稳定。

## 四步安装

1. **下载预装 Lomorage 的系统镜像**，链接见[树莓派安装指南](/zh/docs/Installation/lomorage-service/installation-raspbian/)。
2. 用 balenaEtcher **烧录**到 microSD 卡。
3. **连接**硬盘、网线和电源，等待几分钟完成首次启动。
4. 在手机上**安装 LomoMobile**，创建账号，开始备份。

想保留现有的树莓派系统？指南里也介绍了 **Docker** 和 **apt** 安装方式。其他开发板可参考 [Armbian](/zh/docs/Installation/lomorage-service/installation-armbian/)。

## 让它稳定运行

- **硬盘接带电源的分线器**——供电问题是掉盘最常见的原因。
- **再加一块硬盘**做冗余备份，详细步骤：[树莓派设置冗余备份](/zh/blog/2019/12/24/raspberrypi-hd/)。
- **了解恢复方法。** 即使 microSD 卡坏了，照片仍在硬盘上，数据库也备份在那里——参见[常见问题](/zh/faq/)。
- **树莓派不够用了？** 用我们的[迁移指南](/zh/blog/2023/03/02/migrate_from_pi_win/)把图库搬到 Windows 服务器和更大的硬盘。

## 额外福利：电子相框

预装镜像包含 Lomorage 电子相框程序。接上 HDMI 屏幕，树莓派就能展示家庭照片——或者把[旧安卓平板变成相框](/zh/blog/2021/08/26/zero-cost-android-frame/)。

## 外网访问

想在外面查看原图，可以配置内网穿透或路由器端口映射：[外网访问](/zh/docs/Usage/external-access/)。

树莓派服务器是很好的第一份副本。别忘了还要有第二份和异地副本——[3-2-1 原则](/zh/blog/2026/11/24/321-backup-family-photos/)讲了原因。
