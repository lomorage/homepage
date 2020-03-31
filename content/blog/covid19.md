+++
title = "Setup Covid-19 dashbaord using Raspberry Pi"
tags = ["Raspberry Pi", "dashboard", "Covid-19"]
categories = ["Dashboard"]
date = "2020-03-29T22:43:40"
banner = "img/blog/covid19/covid19.jpg"
+++

It's hard time for everyone, covid-19 is spreading the world, even though you can easily getting the news on your finger tips, it still helpful to setup a dedicated dashboard to show the statistics and relating news of covid-19. The following gives step by step guide to customize your covid-19 dashboard using Raspberry Pi.

<!--more--> 

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/covid19/dashboard-en.png">
</p>
</div>

Table of Contents
=================

   * [Table of Contents](#table-of-contents)
   * [Prepare](#prepare)
   * [How it works](#how-it-works)
   * [Installation](#installation)
      * [1. Install latest NodeJS](#1-install-latest-nodejs)
      * [2. Install MagicMirror](#2-install-magicmirror)
      * [3. Try run with the sample config](#3-try-run-with-the-sample-config)
      * [4. Install MMM-COVID19 module](#4-install-mmm-covid19-module)
      * [5. Add more data sources for MMM-COVID19](#5-add-more-data-sources-for-mmm-covid19)
      * [6. Get more modules](#6-get-more-modules)
   * [Ready to use](#ready-to-use)
      * [1. Configuring the Raspberry Pi](#1-configuring-the-raspberry-pi)
      * [2. Auto Starting MagicMirror](#2-auto-starting-magicmirror)
      * [3. Add cronjob to start/stop MagicMirror](#3-add-cronjob-to-startstop-magicmirror))

# Prepare

The setup the dashboard, you need Raspberry Pi and a HDMI monitor, you can either use big screen in the living room, or use smaller one on the desk. **Notes: This won't work for Raspberry Pi zero/one, there is no NodeJS support for "armv6l" any more.**

# How it works

It's using [MagicMirror](https://github.com/MichMich/MagicMirror) and [covid-19 module](https://github.com/bibaldo/MMM-COVID19).

MagicMirror is an open source modular smart mirror platform, but it doesn't have to be a mirror, it can be used to setup customized dashboard. MagicMirror is using Nodejs for both client and server, the server provides http service for the dashboard and client is using Electron and run it in [Kiosk mode](https://www.kioware.com/resources.aspx?resid=45), which is actually running a browser in fullscreen mode, actually you can just one the ["server only mode"](https://docs.magicmirror.builders/getting-started/installation.html#usage) and open the dashboard in browser on another machine which can access the network. 

MagicMirror defines layout below, and you can put dashboard provided by the modules at specific locations.

![layout](/img/blog/covid19/layout.png)

The modules can define how to fetch the data and how to present it.

That is it!

# Installation

## 1. Install latest NodeJS

[NodeJs-Raspberry-Pi](https://github.com/audstanley/NodeJs-Raspberry-Pi) is very convinient to setup latest NodeJS with one command:

```
$ wget -O - https://raw.githubusercontent.com/audstanley/NodeJs-Raspberry-Pi/master/Install-Node.sh | sudo bash; node -v
```

*Most likely using "apt install" won't get the latest version and MagicMirror will complaint when installation.*

## 2. Install MagicMirror

```
$ git clone https://github.com/MichMich/MagicMirror
$ cd MagicMirror/
$ npm install
```

## 3. Try run with the sample config

MagicMirror comes with some [default modules](https://docs.magicmirror.builders/getting-started/configuration.html#general).

```
# assuming in MagicMirror directory
$ cp config/config.js.sample config/config.js

# use "ctrl+c" to stop, this way of running is for testing
$ npm run
```

You can try play with the options provided by the modules in "config.js", for example, you can add more RSS feed to the "News Feed" module:

```
{
   title: "BBC",
   url: "http://feeds.bbci.co.uk/news/video_and_audio/news_front_page/rss.xml?edition=us"
},
```

Or you can change the position refering to the layout mentioned above.

You can also change the language by changing "language" in "config.js", check [https://github.com/MichMich/MagicMirror/tree/master/translations](https://github.com/MichMich/MagicMirror/tree/master/translations) for languages available.

## 4. Install MMM-COVID19 module

Install in modules directory:

```
# assuming in MagicMirror directory
$ cd modules
$ git clone https://github.com/bibaldo/MMM-COVID19
```

Then config the module in "config/config.js", register accout at [https://rapidapi.com/](https://rapidapi.com/) and replace the "get-your-api-key" below with your own API key. After registered, go to [https://rapidapi.com/astsiatsko/api/coronavirus-monitor](https://rapidapi.com/astsiatsko/api/coronavirus-monitor) and you can find the API key with name "X-RapidAPI-Key".

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

After making changes to "config/config.js", you can restart MagicMirror.

## 5. Add more data sources for MMM-COVID19

The default data sources is lacking details, for example it won't have the data for counties in USA, and no data for cities in China. You can add other data sources, but it won't be a simple configuration, and requires some code changes since the data format is not compatible.

Here is the [changes](https://github.com/fuji246/MMM-COVID19/commit/42356ae5f922359a0b961328a43eddb0d61c4058) made to show counties statistics in USA and to add Chinese translation.

The data source used for USA counties is from [https://github.com/ExpDev07/coronavirus-tracker-api](https://github.com/ExpDev07/coronavirus-tracker-api), no API key required.

Another options people using in other projects is [https://github.com/pomber/covid19](https://github.com/pomber/covid19), there are some other source availble on internet for your country with more details and you can just search with google, and make changes to the code.

## 6. Get more modules

There is a [wiki](https://github.com/MichMich/MagicMirror/wiki/3rd-Party-Modules) on 3rd party modules. The demo dashborad shows on top using the following modules:

- [calendar_monthly](https://github.com/KirAsh4/calendar_monthly/)

- [worldclock](https://github.com/eouia/worldclock)

You can try other modules based on your needs.

# Ready to use

After you tested the dashboard, you still need some configuration to make it ready to use.

## 1. Configuring the Raspberry Pi

You need disable the screensaver, disable the WiFi power save mode and enable OpenGL driver, follow the [wiki](https://github.com/MichMich/MagicMirror/wiki/Configuring-the-Raspberry-Pi) to config the system.

*Notes: I have only one problem with disabling screensaver, when changing "/etc/xdg/lxsession/LXDE-pi/autostart", have to comment line "@xscreensaver -no-splash" to make it work besides adding those 3 lines below it*

```
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
#@xscreensaver -no-splash
@xset s noblank
@xset s off
@xset -dpms
```

## 2. Auto Starting MagicMirror

Follow the steps on the [wiki](https://github.com/MichMich/MagicMirror/wiki/Auto-Starting-MagicMirror) to enable auto start of MagicMirror when system start.

*Notes: If after installing pm2 but it's not found, you probably need to add `PATH="/opt/nodejs/bin:$PATH"` in "~/.profile" and then `source ~/.profile`*

## 3. Add cronjob to start/stop MagicMirror

Add the following lines in "/var/spool/cron/crontabs/pi" which start MagicMirror at 8 am and stop at 9 pm, it also turns on/off the monitor accordingly.

```
00 08 * * * vcgencmd display_power 1;pm2 start mm
00 21 * * * vcgencmd display_power 0;pm2 stop mm
```