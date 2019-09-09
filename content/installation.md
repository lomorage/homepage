   * [Installation Guide](#installation-guide)
      * [1. Overview](#1-overview)
      * [2. Download](#2-download)
         * [Lomorage Service](#lomorage-service)
         * [Lomorage client](#lomorage-client)
      * [3. Setup](#3-setup)
         * [Windows](#windows)
         * [macOS](#macos)
         * [Raspberry Pi](#raspberry-pi)
         * [iOS](#ios)
      * [4. External Access](#4-external-access)
         * [localtunnel](#localtunnel)
            * [1. Install nodejs](#1-install-nodejs)
            * [2. Install localtunnel](#2-install-localtunnel)
            * [3. Run localtunnel](#3-run-localtunnel)
            * [4. Config tunnel service on Lomorage APP](#4-config-tunnel-service-on-lomorage-app)
         * [ngrok](#ngrok)
            * [1. Register](#1-register)
            * [2. Download](#2-download-1)
            * [3. Installation](#3-installation)
            * [4. Connect your account](#4-connect-your-account)
            * [5. Run ngrok](#5-run-ngrok)
            * [6. Config tunnel service on Lomorage APP](#6-config-tunnel-service-on-lomorage-app)

# Installation Guide

## 1. Overview

To use Lomorage, you need run the lomorage service in your local network, either on Windows, OSX or Raspberry Pi. And then you need download the client APP at app store.

## 2. Download

### Lomorage Service

You can choose which version of Lomorage to download based on your perference. Running lomorage service on Windows or OSX give you better performance compared with on Raspberry Pi, the uploading and accessing the backup will be faster, but running Windows or OSX is not energy efficient as using Raspberry Pi. If using Raspberry Pi, you don't need worry about the electricity bill, it is only [about 5$ a year](https://raspberrypi.stackexchange.com/questions/5033/how-much-energy-does-the-raspberry-pi-consume-in-a-day)

<p align="center">

<a href="https://github.com/lomorage/LomoAgentWin/releases/download/lomoagent-2019_08_08.08_39_09.0.364163e/lomoagent.msi" title="Install Lomorage for Windows" class="badge windows">Windows</a>

 &nbsp;
 
<a href="https://github.com/lomorage/LomoAgentOSX/releases/download/2019_09_08.17_42_30.0.c0beee3/LomoAgent.dmg" title="Install Lomorage for macOS" class="badge">macOS</a>

 &nbsp;
 
<a href="https://github.com/lomorage/pi-gen/releases/download/lomorage-v0.5/image_2019-08-01-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

### Lomorage client

Currently only iOS is supported, you can install the app on iPhone or iPad. The app is currently in beta testing, [request](mailto:support@lomorage.com) for testflight access.

<p align="center">
<a href="mailto:support@lomorage.com" title="Request testflight access" class="badge testflight">TestFlight</a>
</p>

<!--<p align="center">
<a href=""><img alt="Download on the App Store" src="/img/installation/app-store-ios.svg" width="220"></a>

 &nbsp;
 
<a href=""><img alt="Get it on Google Play" src="/img/installation/app-store-google.svg" width="220"></a>
</p>-->

## 3. Setup

The first step is to setup the Lomorage service.

### Windows

On Windows, after launch the Lomorage application, you need to set the data directory which is used for storing your photos.

<p align="center">
  <img width="50%" src="/img/installation/windows-lomo-agent.png">
</p>

### macOS

on macOs, after launch the Lomorage application, you need to set the home directory which is used for storing your photos. You can also setup a backup directory which served as redandency backup.

<p align="center">
  <img width="50%" src="/img/installation/osx-lomo-agent.png">
</p>

### Raspberry Pi

To run on Raspberry Pi, you need to order a [Raspberry Pi](https://www.raspberrypi.org/), we have tested the image the following models:

- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

If you don't have one yet, we would recommend the newer version, which gives better performance, and we will support Raspberry Pi 4 soon. The minimum set you need includes:

- Raspberry Pi board
- Power supply
- 16GB MicroSD card

A [Raspberry Pi 3 B+ (PLUS) Starter Kit](https://www.pishop.us/product/raspberry-pi-3-b-plus-starter-kit/) is good enough for the setup.

After you download the customized [OS image](https://github.com/lomorage/pi-gen/releases/download/lomorage-v0.5/image_2019-08-01-lomorage-lite.zip), you can install the image to MicroSD card using [balenaEtcher](https://www.balena.io/etcher/), which is available on both Windows and macOS.

After you insert the MicroSD to your desktop or laptop, just select the image you download, choose the MicroSD drive, and click "Flash", it will be done in a few minutes.

<p align="center">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>

After flushing the image, insert the microSD into Raspberry Pi board, connect USB hard drive with Raspberry Pi, plug in a network cable, plug in the power supply, turn on the power and wait a few minutes for system boot.

### iOS

You can install the application on either iPad or iPhone, the minimum iOS version required in 10.3. Since it's currently in beta testing using testflight, user need to download [testflight](https://apps.apple.com/us/app/testflight/id899247664) first, and then install Lomorage in testflight. Drop us an email to [request](mailto:support@lomorage.com) testflight access.

After lauching Lomorage, it should be able to discover the Lomorage service running in the same network. If you have multiple Lomorage service instances running, those will listed and you can choose one to use.

Then you can create user, choose the place you want to store your photos on the lomorage service, after login, it will take a few minutes to import all your photos on phone, and then you can drop down to start uploading the photos to the place you choose to store your backup, if the photo uploads successfully, there will be a green check on the bottom right. The remote tab will show you those photos stored remotely but not exists locally, so if you delete your local photo that already backup successfully, it will show up in the remote tab view.

<div align="center">
<p class="screenshoot">
  <img width="30%" src="/img/installation/ios-mdns-discover.png">
  <img width="30%" src="/img/installation/ios-createuser.png">
  <img width="30%" src="/img/installation/ios-uploading.png">
  <img width="30%" src="/img/installation/ios-backup.png">
  <img width="30%" src="/img/installation/ios-settings.png">
  <img width="30%" src="/img/installation/ios-share.png">
</p>
</div>

## 4. External Access

Currently external access need some manual setup and some technical background, we will make the process more user friendly later.

There are a few tunnel services available for free use, most tunnel service require a client application running on your device, and setup a connection to the service running by the service provider, and it will give a subdomain name for you to use, if you access the url with that subdomain, the tunnel service will forward the traffic/request to the client application.

You can use [localtunnel](https://localtunnel.me) or [ngrok](https://ngrok.com), both are free tunnel services. localtunnel doesn't require registration, and it can customize the subdomain, so it's pre-installed in Lomorage Raspberry Pi image, while ngrok need register before use, and need pay to customize subdomain, but it's more stable and zero dependencies.

*If you are using Lomorage Raspberry Pi image, the login username is "pi" and password is "raspberry"*

### localtunnel

If you are using Windows or macOS, you need install [nodejs](https://nodejs.org/) first and then install localtunnel. If you are using Lomorage Raspberry Pi image, then localtunnel is already installed and you can skip step 1 an step2.

#### 1. Install nodejs

Download and install the [binaries]((https://nodejs.org/en/download/)) in your platform.

#### 2. Install localtunnel

Open the terminal and type

```
npm install -g localtunnel
```

#### 3. Run localtunnel

Assuming the preferred subdomain name is "allice" (you can choose your own subdomain), then open the terminal and type:

```
lt -s allice -p 8000 --print-requests
```

"-s" specify the subdomain to use, "-p" specify the port forward to, Lomorage service is using "8000" by default, and "--print-requests" will output coming requests.

And if you see the output without any error message, and print out something like:

```
your url is: https://allice.localtunnel.me
```

Then you can start open that url in your browser, and if you see requests log printing in localtunnel output, then the tunnel is setup successfully.

```
Sat Aug 31 2019 11:38:00 GMT-0700 (PDT) GET /
```

<script id="asciicast-265358" src="https://asciinema.org/a/265358.js" async></script>

#### 4. Config tunnel service on Lomorage APP

Open Lomorage APP on the phone, and in the settings tab, fill the tunnel service host and port, the host is like "allice.localtunnel.me", and the port is "443".

### ngrok

#### 1. Register

Sign up a ngrok account [here](https://dashboard.ngrok.com/signup), after that, it will show up a "Setup & Installation" page.

#### 2. Download

ngrok is just one binary, you can download the version on your platform.

If you are on Raspberry Pi, you can copy the link of Linux(ARM) on the "Setup & Installation" page, which is "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip" for now, and download it via "wget".

```
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
```

#### 3. Installation

unzip and get the binary. You can double click on Windows or macOS to unzip it.

If you are using Raspberry Pi, use "unzip" command:

```
unzip ngrok-stable-linux-arm.zip
```

#### 4. Connect your account

On the "Setup & Installation" page step 3, it shows the “authtoken”, you need open **terminal** to run ngrok to add the authtoken to the config file.

```
./ngrok authtoken [your-authtoken-show-in-step-3]
```

#### 5. Run ngrok

Lomorage service is using "8000" by default, and ngrok can't customize subdomain with free account. After runnig successfully, it will show the tunnel url, the subdomain is a random string which might change in next run.

```
./ngrok http 8000
```

#### 6. Config tunnel service on Lomorage APP

Open Lomorage APP on the phone, and in the settings tab, fill the tunnel service host and port, the host is like "2e30eea5.ngrok.io", and the port is "443".


<script id="asciicast-265359" src="https://asciinema.org/a/265359.js" async></script>

<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"             title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
