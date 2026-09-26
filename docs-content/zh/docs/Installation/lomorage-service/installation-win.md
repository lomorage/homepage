---
title: Windows
weight: 4
---

# 在Windows上安装"Lomorage照片助手"

## 1. 安装

打开 **PowerShell**（不需要以管理员身份运行），粘贴执行：

```powershell
irm https://lomorage.com/windows/install.ps1 | iex
```

这会自动下载 `lomod.exe` 以及它需要的所有组件（vips、exiftool、ffmpeg），安装到你自己的用户目录下并启动——没有安装向导窗口，不需要管理员权限，也不需要重启电脑。

{{< hint warning >}}
如果你在国内，GitHub 下载比较慢或者失败，可以先设置这个环境变量，让下载走加速代理：

```powershell
$env:LOMOD_CHINA=1; irm https://lomorage.com/windows/install.ps1 | iex
```
{{< /hint >}}

如果第一次启动时 Windows 弹出防火墙提示（这样你的手机才能在局域网内访问它），请选择 **专用网络（Private networks）**，点击 **允许访问**。

## 2. 数据目录

默认情况下，你的照片和视频会存储在你自己用户目录下的 `Pictures\Lomorage` 文件夹里——不需要额外配置就能直接使用。

如果你想用别的磁盘或文件夹（比如外接硬盘），不要直接用 `irm ... | iex` 这种一行命令，而是先把脚本下载下来，再带上 `-DataDir` 参数运行：

```powershell
irm https://lomorage.com/windows/install.ps1 -OutFile install.ps1
./install.ps1 -DataDir "D:\Lomorage"
```

以后想把已安装的实例改到新目录，也是用同样的方式重新运行安装脚本——可以随时安全地重复运行。

## 3. 打开 Lomorage

安装完成后，"开始"菜单和系统托盘（屏幕右下角）都会出现一个 **Lomorage** 图标——双击任意一个都可以在浏览器里打开网页客户端。

在托盘图标上右键，可以看到 **Start / Stop / Restart**（启动/停止/重启），或者选择 **Quit** 完全退出。如果不小心退出了，去"开始"菜单搜索 **Lomorage** 就能重新打开，不需要重新安装。

## 4. 从手机或其他电脑访问

找到这台电脑的 IP 地址，然后在同一网络下的手机或其他设备浏览器里打开 `http://这台电脑的IP:8000`。

## 5. 自动更新

Lomorage 每天会在后台自动检查并安装新版本，不需要任何操作。如果你想立刻更新，直接重新执行第 1 步的安装命令即可——可以安全地重复运行，不会影响你的照片。

## 6. 卸载

目前还没有一键卸载工具，如果需要完全移除：

1. 在托盘图标上右键，选择 **Quit**。
2. 删除"开始"菜单里的 `Lomorage.lnk` 快捷方式，以及 `shell:startup`（在文件资源管理器地址栏粘贴这个可以直接跳转过去）里的那个。
3. 打开"任务计划程序"（Task Scheduler），如果有 **LomorageUpdate** 任务，删除它。
4. 删除安装目录 `%LOCALAPPDATA%\Lomorage\lomod`。

第 2 步里数据目录中的照片不会受以上任何步骤影响。

Enjoy!

**需要帮助？请发邮件至 [support@lomorage.com](mailto:support@lomorage.com)。**

{{< hint info >}}
**HEIC/HEVC 不需要额外依赖。** Lomorage 已经包含处理苹果手机照片和视频所需的组件，网页中可以直接查看。

只有当你希望用 Windows 资源管理器或“照片”应用直接打开磁盘上的 HEIC/HEVC 原文件时，才可能需要安装微软提供的 [HEIF 图像扩展](https://apps.microsoft.com/detail/9pmmsr1cgpwg) 和 [HEVC 视频扩展](https://apps.microsoft.com/detail/9nmzlz57r3t7)。这两个扩展是可选的，不影响 Lomorage 的备份和网页浏览功能。
{{< /hint >}}

## 7. 需要帮助？

请发邮件至 [support@lomorage.com](mailto:support@lomorage.com)，我们会尽快回复。
