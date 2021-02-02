Table of Contents
=================

   * [Install Lomorage Service on Raspberry Pi](#install-lomorage-service-on-raspberry-pi)
      * [Install with prebuild OS image](#install-with-prebuild-os-image)
      * [Docker installation](#docker-installation)
      * [Apt installation](#apt-installation)
         * [1. Add lomoware source](#1-add-lomoware-source)
         * [2. Install Lomorage](#2-install-lomorage)
         * [3. Change mount directory and username if needed](#3-change-mount-directory-and-username-if-needed)
         * [4. Run](#4-run)

# Install Lomorage Service on Raspberry Pi

To run on Raspberry Pi, you need to order a [Raspberry Pi](https://www.raspberrypi.org/), we have tested the image the following models:

- [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)

If you don't have one yet, we would recommend the newer version, which gives better performance. The minimum set you need includes:

- Raspberry Pi board
- Power supply
- 16GB MicroSD card

A [Raspberry Pi 3 B+ (PLUS) Starter Kit](https://www.pishop.us/product/raspberry-pi-3-b-plus-starter-kit/) is good enough for the setup.

**There are 3 options to install Lomorage service on Raspberry Pi**, one is using the prebuild OS image which has all the dependencies installed, or you can run docker image on your existing running Raspberry Pi, or if you can just use APT install.

## Install with prebuild OS image

The prebuild image includes all Lomorage packages, including:

- lomo-backend: Lomorage service backend

- lomo-web: Lomorage web application

- lomo-base: network configure tool, button control, hard drive mount tool (usbmount modification), bluetooth console

- lomo-frame: the digital frame application

Click the link below to download the prebuild OS image.

<p align="center">
<a href="https://github.com/lomorage/pi-gen/releases/download/2021_01_17.00_33_39.0.f0245af/image_2021-01-17-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

After you download the customized OS image, you can install the image to MicroSD card using [balenaEtcher](https://www.balena.io/etcher/), which is available on both Windows and macOS.

After you insert the MicroSD to your desktop or laptop, just select the image you download, choose the MicroSD drive, and click "Flash", it will be done in a few minutes.

<p align="center">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>

After flushing the image, insert the microSD into Raspberry Pi board, connect USB hard drive with Raspberry Pi, plug in a network cable, plug in the power supply, turn on the power and wait a few minutes for system boot.

If you have HDMI connected, after system boot successfully, it will show up a screen that no able to find any assets, and will also show a QRCode for register the lomo frame, **please create user on iOS/Android APP first before scanning the QRCode to bind the lomo frame**. You can upload photos using Lomorage Phone app, and then press "r" to rescan. If you want to quit to terminal to do some configuration, just press "ESC" and then "Ctrl+Alt+F2", after you made any changes and want to start lomo-frame, use command `sudo service supervisor restart`.

*The default login username is "pi" and password is "raspberry"*

We suggest use cable to provide better performance, but if you prefer to use WiFi, you can login Raspberry Pi and use the command `wifi_switch.sh client "wifi-ssid" wifi-password`, replace "wifi-ssid" and "wifi-password" with those of your wifi network. *Make sure you have quotation mark around "wifi-ssid" if you have space or unicode character in it, for example `wifi_switch.sh client "Lomorage's 2.4G" mypassword`.*

## Docker installation

Please refer to [lomo-docker](https://github.com/lomorage/lomo-docker) for installation with docker image. You should use the arm image "lomorage/raspberrypi-lomorage:latest".

## Apt installation

If you have the official Raspbian image installed already, APT installation would be the quickest way to install.

### 1. Add lomoware source

```
sudo apt install -y ca-certificates python-certifi python3-certifi
sudo update-ca-certificates --fresh
wget -qO - https://raw.githubusercontent.com/lomoware/lomoware.github.io/master/debian/gpg.key | sudo apt-key add -
```

If you are using jessie:

```
echo "deb https://lomoware.github.io/debian/jessie jessie main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

If you are using buster:

```
echo "deb https://lomoware.github.io/debian/buster buster main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

then run:

```
sudo apt update
```

### 2. Install Lomorage

You need at least lomo-vips and lomo-backend installed.

- lomo-backend: mandatory, Lomorage service backend

- lomo-web: optional, Lomorage web application

- lomo-base: optional, network configure tool, button control, hard drive mount tool, bluetooth console

- lomo-vips: mandatory, lomorage vips clone. (A fast image processing library with low memory needs), used by lomo-backend

- lomo-frame: optional, the digital frame application

```
sudo apt install lomo-base lomo-vips lomo-backend lomo-web lomo-frame -y
```

### 3. Change mount directory and username if needed

You may need to specify the mount directory if the USB drive is not mounted in "/media" directory. 

For example if you are using PCManFM, then the mount directory will be "/media/pi". To specify the mount directory to be "/media/pi", modify `ExecStart` in "/lib/systemd/system/lomod.service", and add parameter "--mount-dir" as below

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir /media/pi  --max-upload 1 --max-fetch-preview 3
```

**Make sure the user has the r/w permission for the "mount-dir" set above**

### 4. Run

Restart Lomorage service:

```
# restart lomo-backend
sudo systemctl restart lomod

# restart lomo-web
sudo systemctl restart lomow

# restart lomo-frame
sudo service supervisor restart
```
