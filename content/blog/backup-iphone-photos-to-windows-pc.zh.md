+++
title = "不用 iCloud，怎么把 iPhone 照片备份到 Windows 电脑"
tags = ["iPhone", "Windows", "iCloud", "备份"]
categories = ["BLOG"]
date = "2026-11-24T11:00:00-08:00"
+++

iPhone 提示存储空间满了，苹果会建议你买更大的 iCloud 套餐，每个月一直付下去。其实还有另一个办法：把照片备份到家里已有的 Windows 电脑上，原片存在自己家里，确认备份无误之后，再放心地从手机上删掉。

这就是 Lomorage 的做法。电脑端免费，手机 App 一次性 $1.99，没有订阅。

<!--more-->

## 先算一笔账：iCloud 用久了并不便宜

iCloud 免费只有 5 GB，拍一阵照片视频就满了。美国 iCloud+ 的价格（2026 年 11 月 24 日核实）是：

| 套餐 | 每月 | 每年 | 5 年 |
| --- | --- | --- | --- |
| iCloud+ 50 GB | $0.99 | $11.88 | $59.40 |
| iCloud+ 200 GB | $2.99 | $35.88 | $179.40 |
| iCloud+ 2 TB | $9.99 | $119.88 | $599.40 |

用 Lomorage 的话，手机 App 一次性 $1.99，电脑端免费，照片存在自己电脑的硬盘里，硬盘空间多半家里已经有了。实话实说也有代价：备份时电脑要开着、能连上；家里硬盘也不是万无一失，无法替代的照片要再多备一份。

## 需要准备什么

- 一台 Windows 电脑（x64），硬盘有足够空闲空间
- 一部 iPhone，iOS 15.1 或更高版本
- 手机和电脑连同一个家庭 Wi-Fi
- 备份期间电脑保持开机

## 第一步：在 Windows 电脑上安装 Lomorage

在电脑上按 Win + R，输入 `cmd`，按回车。复制下面这条命令，粘贴后按回车。不需要管理员密码。

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm 'https://lomorage.com/windows/install.ps1' -OutFile "$env:TEMP\lomorage-install.ps1"; & "$env:TEMP\lomorage-install.ps1""
```

等设置页面在浏览器里打开。第一次设置时，页面上会显示一个二维码，先别关。

## 第二步：手机装 App，扫码连接

在 iPhone 上安装 [Lomorage: Free Up Photo Space](https://apps.apple.com/us/app/lomomobile/id6771038226?ct=blog-iphone-windows)，连上同一个家庭 Wi-Fi，用 App 里的扫码功能扫描电脑上的设置码，然后创建账号、选择照片存在哪个盘。App 会推荐空闲空间最大的硬盘。

## 第三步：允许照片权限，等第一次备份完成

允许 App 访问你要备份的照片。建议选“允许访问所有照片”，这样备份才是完整的：只允许部分照片的话，就只会备份那一部分。

第一次备份照片多的话，让 App 保持打开。备份完成后，点开几张照片和视频，确认原图能正常打开、画质完整，包括实况照片（Live Photos）。

## 第四步：确认无误后，再释放手机空间

确认备份完成、原图都能正常打开之后，再用 App 里的 Free Up Space（释放空间）。它会列出已经备份好的大视频和照片，让你清楚知道哪些删了也不会丢。所有删除都由你自己决定，App 不会自动删。

## 几个要说在前面的限制

- 备份时、以及查看存在电脑上的原图时，电脑要开着、能连上。手机上缓存过的照片可以离线看，但别默认所有原图都能离线看。
- 从手机上删照片之前，一定要先确认备份完成。
- 本地硬盘也会坏，和所有硬盘一样。最重要的照片，再往另一块硬盘多备一份。
- 家人也可以一起用：每个人单独创建一个账号，扫码连上同一台电脑就行。

## 开始使用

- iPhone：[App Store 上的 Lomorage: Free Up Photo Space](https://apps.apple.com/us/app/lomomobile/id6771038226?ct=blog-iphone-windows) —— $1.99 一次性买断，无订阅
- Android：[Google Play 上的 Lomorage: Free Up Photo Space](https://play.google.com/store/apps/details?id=com.wtao.lomo&utm_source=blog&utm_medium=article&utm_campaign=iphone-windows) —— $1.99 一次性买断，无订阅
- Windows 和 Mac 电脑端：免费，见 [lomorage.com](https://lomorage.com/)
