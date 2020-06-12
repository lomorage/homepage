+++
title = "使用树莓派制作新冠病毒电子看板"
tags = ["树莓派", "看板", "新冠病毒"]
categories = ["看板"]
date = "2020-03-29T22:43:40"
banner = "img/blog/covid19/covid19.jpg"
+++

新冠病毒肆掠全球，虽然现在可以很容易的在手机上查看新闻和数据，但是设置一个专门的电子看板，显示新闻和统计会更加方便。下面会讲解如何一步步的在树莓派上安装和配置“新冠病毒电子看板”。

<!--more--> 

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/covid19/dashboard-zh.png">
</p>
</div>

目录
=================

   * [准备工作](#准备工作)
   * [工作原理](#工作原理)
   * [安装](#安装)
      * [1. 安装最新版本的NodeJS](#1-安装最新版本的nodejs)
      * [2. 安装MagicMirror](#2-安装magicmirror)
      * [3. 使用默认的配置模版](#3-使用默认的配置模版)
      * [4. 安装MMM-COVID19模块](#4-安装mmm-covid19模块)
      * [5. 为MMM-COVID19添加更多的数据源](#5-为mmm-covid19添加更多的数据源)
      * [6. 获取更多的模块](#6-获取更多的模块)
   * [准备投入使用](#准备投入使用)
      * [1. 配置树莓派](#1-配置树莓派)
      * [2. 开机启动MagicMirror](#2-开机启动magicmirror)
      * [3. 添加Cronjob启动关闭MagicMirror](#3-添加cronjob启动关闭magicmirror)

# 准备工作

您需要一个树莓派和HDMI的显示器，你可以放置一个大屏幕在客厅，也可以在桌面上放置一个小屏幕作为摆台。

**注意: 树莓派0/1不支持，NodeJS不支持"armv6l"平台了。**

# 工作原理

使用的开源软件有[MagicMirror](https://github.com/MichMich/MagicMirror)和[covid-19模块](https://github.com/bibaldo/MMM-COVID19).

MagicMirror是一个开源的智能镜子平台, 但实际上使用它并不需要一面镜子，它可以被用来定制电子看板。MagicMirror的客户端和服务器程序使用了Nodejs，服务器通过http提供看板服务，客户端使用Electron，运行[Kiosk模式](https://www.kioware.com/resources.aspx?resid=45), 也就是浏览器的全屏模式, 您也可以运行["服务器模式"](https://docs.magicmirror.builders/getting-started/installation.html#usage)，并在另外一台电脑的浏览器上访问电子看板。

MagicMirror定义的如下的布局，您可以选择把模块放置的看板特定的位置。

![layout](/img/blog/covid19/layout.png)

模块定义了如何获取和显示数据。

大体上来说就这么简单!

# 安装

如果您使用的是lite的系统镜像，您需要先安装桌面系统。

```
sudo apt-get update 
sudo apt-get -y dist-upgrade
sudo apt-get install raspberrypi-ui-mods -y
sudo apt-get install libgdk-pixbuf2.0-dev -y
sudo ln -s /usr/lib/*/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders /usr/local/bin/gdk-pixbuf-query-loaders
sudo gdk-pixbuf-query-loaders --update-cache -y
sudo apt install ca-certificates python-certifi python3-certifi -y
sudo apt-get install -y --reinstall ca-certificates
sudo update-ca-certificates --fresh
```

## 1. 安装最新版本的NodeJS

[NodeJs-Raspberry-Pi](https://github.com/audstanley/NodeJs-Raspberry-Pi)能非常方便的一行命令安装NodeJS:

```
$ wget -O - https://raw.githubusercontent.com/audstanley/NodeJs-Raspberry-Pi/master/Install-Node.sh | sudo bash; node -v
```

*使用"apt install"很有可能不会安装新版本的NodeJS，MagicMirror在后续的安装过程只会报错。*

## 2. 安装MagicMirror

```
$ git clone https://github.com/MichMich/MagicMirror
$ cd MagicMirror/
$ npm install
```

## 3. 使用默认的配置模版

MagicMirror已经安装了一些[默认模块](https://docs.magicmirror.builders/getting-started/configuration.html#general).

```
# 假设在MagicMirror目录
$ cp config/config.js.sample config/config.js

# 可以使用"ctrl+c"停止, 下面的运行方式仅仅用于测试
$ npm run
```

您可以尝试去修改"config.js"中模块的选项，比如，您可以给"News Feed"模块添加更多的[RSS源](https://docs.rsshub.app/):

```
{
   title: "BBC",
   url: "http://feeds.bbci.co.uk/news/video_and_audio/news_front_page/rss.xml?edition=us"
},
```

您也可以更加上面的布局图来修改模块的位置（"position"参数）。

您也可以修改默认的语言（"language"参数)，[https://github.com/MichMich/MagicMirror/tree/master/translations](https://github.com/MichMich/MagicMirror/tree/master/translations)可以查看所有可用的语言选项。改成其他语言要记得安装相关的字体，比如中文字体:

```
sudo apt install -y fonts-arphic-uming ttf-wqy-microhei
```

## 4. 安装MMM-COVID19模块

将模块安装在"modules"目录下:

```
# 假设在MagicMirror目录
$ cd modules
$ git clone https://github.com/bibaldo/MMM-COVID19
```

然后在"config/config.js"文件中添加模块的配置, 在[https://rapidapi.com/](https://rapidapi.com/)注册，将下面的"get-your-api-key"替换为您自己的API密钥。[https://rapidapi.com/astsiatsko/api/coronavirus-monitor](https://rapidapi.com/astsiatsko/api/coronavirus-monitor)，"X-RapidAPI-Key"就是API密钥。

```
  {
    module: 'MMM-COVID19',
    position: "bottom_bar",
    config: {
      headerRowClass: "big",
      infoRowClass: "big",
      worldStats: true,
      countries: ["USA", "China"],
      lastUpdateInfo: true,
      delta: true,
      rapidapiKey: "get-your-api-key",
   }
  },
```

修改了"config/config.js"后，您需要重启MagicMirror。

## 5. 为MMM-COVID19添加更多的数据源

默认的数据源缺少一些详细信息，比如没有美国每个郡县的统计，没有中国城市的统计。您也可以添加其他的数据源，但那个就不仅仅是简单的配置了，需要修改一些代码，因为不同的数据源的格式不一样。

这里有个[改动示例](https://github.com/fuji246/MMM-COVID19/commit/42356ae5f922359a0b961328a43eddb0d61c4058)添加了美国郡县的统计数据，并做了汉化。这个[改动示例](https://github.com/fuji246/MMM-COVID19/commit/e4d9850a1faf3631bebf10b11fd70133a8921296)添加了中国城市的统计数据。

美国的数据来源[https://github.com/ExpDev07/coronavirus-tracker-api](https://github.com/ExpDev07/coronavirus-tracker-api)，中国的数据来源[https://c.m.163.com/ug/api/wuhan/app/data/list-total](https://c.m.163.com/ug/api/wuhan/app/data/list-total)，都不需要申请API密钥。

其他的数据源[https://github.com/pomber/covid19](https://github.com/pomber/covid19), 您也可以自行去网上查找合适的数据源，并对代码做相应的改动。

## 6. 获取更多的模块

这个[wiki](https://github.com/MichMich/MagicMirror/wiki/3rd-Party-Modules)列举了所有的第三方模块。最上面的示例图片使用了下面的模块:

- [calendar_monthly](https://github.com/KirAsh4/calendar_monthly/)

- [worldclock](https://github.com/eouia/worldclock)

您也可以根据自己的需求尝试其他的模块。

# 准备投入使用

测试好电子看板后，您还需要一些额外的配置，才能将其投入使用。

## 1. 配置树莓派

您需要关掉屏保，禁止无线网卡的休眠模式，打开OpenGL驱动，参考[wiki](https://github.com/MichMich/MagicMirror/wiki/Configuring-the-Raspberry-Pi)进行配置。

*注意: 关闭屏保那一步，在修改"/etc/xdg/lxsession/LXDE-pi/autostart"文件时, 需要注释掉这一行"@xscreensaver -no-splash"（使用#），这个在上面的说明里面没有*

```
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
#@xscreensaver -no-splash
@xset s noblank
@xset s off
@xset -dpms
```

## 2. 开机启动MagicMirror

参考[wiki](https://github.com/MichMich/MagicMirror/wiki/Auto-Starting-MagicMirror)设置MagicMirror开机启动。

*注意: 如果安装了pm2后却找不到这个命令，您需要将`PATH="/opt/nodejs/bin:$PATH"`添加到"~/.profile"文件中，然后`source ~/.profile`更新PATH环境变量*

## 3. 添加Cronjob启动关闭MagicMirror

在"/var/spool/cron/crontabs/pi"文件中添加如下的内容，控制MagicMirror在早上8 am启动，晚上9 pm关闭，并打开和关闭HDMI显示器。

```
00 08 * * * vcgencmd display_power 1;pm2 start mm
00 21 * * * vcgencmd display_power 0;pm2 stop mm
```