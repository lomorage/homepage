---
title: OSX
weight: 5
---

# 在MacOS上安装"Lomorage照片助手"程序

## 1. 安装

打开"终端"（不需要 `sudo`），执行：

```bash
curl -fsSL https://lomorage.com/mac/install.sh | bash
```

这会自动下载 `lomod` 以及它需要的所有组件（vips、exiftool、ffmpeg），安装到你自己的用户目录下并启动——没有 `.dmg` 安装包，不需要输入管理员密码，也不需要重启电脑。

{{< hint warning >}}
如果你在国内，GitHub 下载比较慢或者失败，可以走加速代理：

```bash
curl -fsSL https://lomorage.com/mac/install.sh | LOMOD_CHINA=1 bash
```
{{< /hint >}}

如果第一次启动时 macOS 弹出防火墙或网络访问提示（这样你的手机才能在局域网内访问它），点击 **允许**。

## 2. 数据目录

默认情况下，你的照片和视频会存储在你自己主目录下的 `Pictures/Lomorage` 文件夹里——不需要额外配置就能直接使用。

如果你想用别的磁盘或文件夹（比如外接硬盘），不要直接用管道方式运行脚本，而是先下载下来，再带上 `--data-dir` 参数运行：

```bash
curl -fsSL https://lomorage.com/mac/install.sh -o install.sh
chmod +x install.sh
./install.sh --data-dir "/Volumes/MyDrive/Lomorage"
```

以后想把已安装的实例改到新目录，也是用同样的方式重新运行安装脚本——可以随时安全地重复运行。

## 3. 打开 Lomorage

安装完成后，菜单栏会出现一个 **Lomorage** 图标，`~/Applications` 里也会多出一个 **Lomorage** 应用——用 Spotlight（⌘空格，输入"Lomorage"）或 Launchpad 就能像打开其他 Mac 应用一样找到它，双击即可在浏览器里打开网页客户端。

点击菜单栏图标，可以看到 **Start / Stop / Restart**（启动/停止/重启），或者选择 **Quit** 完全退出。如果不小心退出了，用同样的方式（Spotlight、Launchpad 或 `~/Applications`）重新打开就行，不需要重新安装。

## 4. 从手机或其他电脑访问

找到这台 Mac 的 IP 地址，然后在同一网络下的手机或其他设备浏览器里打开 `http://这台Mac的IP:8000`。

## 5. 更新

macOS 版目前还没有接入自动后台更新。想更新的话，直接重新执行第 1 步的安装命令即可——可以安全地重复运行，不会影响你的照片。

## 6. 卸载

目前还没有一键卸载工具，如果需要完全移除：

1. 点击菜单栏图标，选择 **Quit**。
2. 删除 `~/Applications/Lomorage.app`。
3. 执行 `launchctl bootout gui/$(id -u)/com.lomorage.lomod`，然后删除
   `~/Library/LaunchAgents/com.lomorage.lomod.plist`。
4. 删除安装目录 `~/Library/Application Support/Lomorage/lomod`。

第 2 步里数据目录中的照片不会受以上任何步骤影响。

Enjoy!

**联系我们: support@lomorage.com**
