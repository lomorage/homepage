+++
title = "Installation Guide"
+++

   * [Installation Guide](#installation-guide)
      * [1. Overview](#1-overview)
      * [2. Download](#2-download)
         * [Lomorage Service](#lomorage-service)
         * [Lomorage client](#lomorage-client)
      * [3. Setup](#3-setup)
         * [Windows](#windows)
         * [macOS](#macos)
         * [Raspberry Pi](#raspberry-pi)
            * [Install with prebuild OS image](#install-with-prebuild-os-image)
            * [Install on existing Raspbian](#install-on-existing-raspbian)
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

To use Lomorage, you need to run the Lomorage service in your local network, either on Windows, OSX or Raspberry Pi. And then you need to download the client APP at the APP store.

## 2. Download

### Lomorage Service

You can choose which version of Lomorage to download based on your preference. Running Lomorage service on Windows or OSX gives you better performance compared with on Raspberry Pi, the uploading and accessing the backup will be faster, but running Windows or OSX is not energy efficient as using Raspberry Pi. If using Raspberry Pi, you don't need to worry about the electricity bill, it is only [about 5$ a year](https://raspberrypi.stackexchange.com/questions/5033/how-much-energy-does-the-raspberry-pi-consume-in-a-day)

<p align="center">

<a href="https://github.com/lomorage/LomoAgentWin/releases/download/2019_09_28.11_56_35.0.a0f75cb/lomoagent.msi" title="Install Lomorage for Windows" class="badge windows">Windows</a>

 &nbsp;

<a href="https://github.com/lomorage/LomoAgentOSX/releases/download/2019_09_11.23_30_31.0.bb65c8a/LomoAgent.dmg" title="Install Lomorage for macOS" class="badge">macOS</a>

 &nbsp;

<a href="https://github.com/lomorage/pi-gen/releases/download/2019_09_26.21_07_53.0.0cbe0a8/image_2019-09-26-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

### Lomorage client

Curently support iPhone and iPad。

<p align="center">
<a href="https://apps.apple.com/us/app/lomorage/id1451516091"><img alt="Download on the App Store" src="/img/installation/app-store-ios.svg" width="220"></a>
<!--
 &nbsp;

<a href=""><img alt="Get it on Google Play" src="/img/installation/app-store-google.svg" width="220"></a>
-->
</p>

## 3. Setup

The first step is to set up the Lomorage service.

### Windows

<span>1.</span> double click "lomoagent.msi" to start installation。If Windows Defender shows "lomoagent.msi" as unknown application, please follow the steps below to allow it to run。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-defender-1.png">
  <img width="50%" src="/img/installation/windows-defender-2.png">
</p>
</div>

<span>2.</span> Follow the wizzard to finish the installation, in the End-User License Agreement, please checked the box as below。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-install-1.png">
  <img width="50%" src="/img/installation/windows-install-2.png">
  <img width="50%" src="/img/installation/windows-install-3.png">
</p>
</div>

<span>3.</span> Now you should see the lomoagent icon on your desktop, you can double click to start the lomoagent. If you meet below dialog popuped up by the Windows os, please select "Private networks ..." one and click the Allow access.

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-firewall.png">
</p>
</div>

<span>4.</span> You will see below picture while you start the lomoagent, **You need to config the "Data directory" before using it**，"Data directory" is used to save the photos and videos uploading from your phone。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/windows-lomo-agent.png">
</p>
</div>

### macOS

<span>1.</span> Double click "LomoAgent.dmg" to start installation, and follow the steps below to finish the installation。

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/osx-install-1.png">
  <img width="50%" src="/img/installation/osx-install-2.png">
  <img width="50%" src="/img/installation/osx-install-3.png">
</p>
</div>

<span>2.</span> Run LomoAgent Application，please allow network access for LomoAgent if firewall is triggered。

<span>3.</span> After launch the Lomorage application，**You need to set the "Home directory" before using Lomorage**，"Home directory" is used to save the photos and videos uploading from your phone。You can also set up a backup directory which served as redundancy backup.

<div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/installation/osx-lomo-agent.png">
</p>
</div>

### Raspberry Pi

To run on Raspberry Pi, you need to order a [Raspberry Pi](https://www.raspberrypi.org/), we have tested the image the following models:

- [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

If you don't have one yet, we would recommend the newer version, which gives better performance, and we will support Raspberry Pi 4 soon. The minimum set you need includes:

- Raspberry Pi board
- Power supply
- 16GB MicroSD card

A [Raspberry Pi 3 B+ (PLUS) Starter Kit](https://www.pishop.us/product/raspberry-pi-3-b-plus-starter-kit/) is good enough for the setup.

There are two options to install Lomorage service on Raspberry Pi, one is using the prebuild OS image which has all the dependencies installed, another one is manaully installation if you already have Raspberry Pi setup and running for other purpose.

#### Install with prebuild OS image

After you download the customized [OS image](https://github.com/lomorage/pi-gen/releases/download/2019_09_26.21_07_53.0.0cbe0a8/image_2019-09-26-lomorage-lite.zip), you can install the image to MicroSD card using [balenaEtcher](https://www.balena.io/etcher/), which is available on both Windows and macOS.

After you insert the MicroSD to your desktop or laptop, just select the image you download, choose the MicroSD drive, and click "Flash", it will be done in a few minutes.

<p align="center">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>

After flushing the image, insert the microSD into Raspberry Pi board, connect USB hard drive with Raspberry Pi, plug in a network cable, plug in the power supply, turn on the power and wait a few minutes for system boot.

We strongely suggest use cable to provide better performance, but if you prefer to use WiFi, you can login Raspberry Pi and use the command `wifi_switch client [wifi-ssid] [wifi-password]`, replace "[wifi-ssid]" and "[wifi-password]" with those of your wifi network.

*The login username is "pi" and password is "raspberry"*

#### Install on existing Raspbian

**step 1. Add lomoware source**

```
wget -qO - https://raw.githubusercontent.com/lomoware/lomoware.github.io/master/debian/gpg.key | sudo apt-key add -
```

If you are using jessie:

```
echo "deb https://lomoware.github.io/debian jessie main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

If you are using buster:

```
echo "deb https://lomoware.github.io/debian/buster buster main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

then run:

```
sudo apt update
```

**step 2. Install ffmpeg and rsync**

```
sudo apt install ffmpeg rsync -y
```

**step 3. Install file systems support**

```
sudo apt install exfat-fuse ntfs-3g hfsplus hfsutils hfsprogs -y
```

**step 4. Install usbmount**

You can skip this if you are using desktop image which has PCManFM installed that can auto mount the USB drive. If you are using the Lite image, and you can use usbmount to auto mount the USB drive.

The usbmount we are using is a modified version which mounts a specfic USB drive to a fixed mount point in "/media" directory, which means the order you plugin the drives doesn't matter, the mount point is always the same.

```
sudo apt install lockfile-progs -y
sudo mkdir /etc/usbmount
sudo mkdir /usr/share/usbmount
sudo wget -qO /etc/usbmount/usbmount.conf https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount.conf
sudo wget -qO /usr/share/usbmount/usbmount https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount
sudo chmod +x /usr/share/usbmount/usbmount
sudo wget -qO /etc/udev/rules.d/usbmount.rules https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount.rules
sudo wget -qO /etc/systemd/system/usbmount@.service https://raw.githubusercontent.com/lomorage/pi-gen/lomorage/stage2/01-sys-tweaks/files/usbmount%40.service
```

**step 5. Install Lomorage service**

```
sudo apt install lomo-vips lomo-backend -y
```

**step 6. Change mount directory if needed**

If you are not using the usbmount in step 4, you may need to specify the mount directory if the USB drive is not mounted in "/media" directory, for example if you are using PCManFM, then the mount directory will be "/media/pi".

To specify the mount directory to be "/media/pi", modify `ExecStart` in "lib/systemd/system/lomod.service", and add paramter "--mount-dir" as below

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir /media/pi  --max-upload 1 --max-fetch-preview 3
```

Then restart Lomorage service:

```
sudo systemctl restart lomod
```

### iOS

You can install the application on either iPad or iPhone, the minimum iOS version required in 10.3. Since it's currently in beta testing using testflight, user needs to download [testflight](https://apps.apple.com/us/app/testflight/id899247664) first, and then install Lomorage in testflight. Drop us an email to [request](mailto:support@lomorage.com) testflight access.

After launching Lomorage, it should be able to discover the Lomorage service running in the same network. If you have multiple Lomorage service instances running, those will be listed and you can choose one to use. If Lomorage service can't be discovered automatically, you can discover the service via QRCode Scanning when using Windows or MacOS LomoAgent (open settings in LomoAgent to show the QRCode), or you can input the IP address and port manually.

Then you can create user, choose the place you want to store your photos on the Lomorage service, after login, it will take a few minutes to import all your photos on phone, and then you can drop down to start uploading the photos to the place you choose to store your backup, if the photo uploads successfully, there will be a green check on the bottom right. The remote tab will show you those photos stored remotely but not exists locally, so if you delete your local photo that already backup successfully, it will show up in the remote tab view.

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

Currently, external access need some manual setup and some technical background, we will make the process more user-friendly later.

There are a few tunnel services available for free use, most tunnel services require a client application running on your device, and set up a connection to the service running by the service provider, and it will give a subdomain name for you to use, if you access the URL with that subdomain, the tunnel service will forward the traffic/request to the client application.

You can use [localtunnel](https://localtunnel.me) or [ngrok](https://ngrok.com), both are free tunnel services. localtunnel doesn't require registration, and it can customize the subdomain, so it's pre-installed in Lomorage Raspberry Pi image, while ngrok need register before use, and need pay to customize subdomain, but it's more stable and zero dependencies.

*If you are using Lomorage Raspberry Pi image, the login username is "pi" and password is "raspberry"*

### localtunnel

If you are using Windows or macOS, you need to install [nodejs](https://nodejs.org/) first and then install localtunnel. If you are using Lomorage Raspberry Pi image, then you can run command `sudo localtunnel_install.sh` to install localtunnel, and you can skip step 1 an step2.

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

Then you can start open that URL in your browser, and if you see requests log printing in localtunnel output, then the tunnel is set up successfully.

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
