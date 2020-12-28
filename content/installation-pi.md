Table of Contents
=================

   * [Install Lomorage Service on Raspberry Pi](#install-lomorage-service-on-raspberry-pi)
      * [Install with prebuild OS image](#install-with-prebuild-os-image)
      * [Docker installation](#docker-installation)
         * [1. Install Docker on Raspberry Pi](#1-install-docker-on-raspberry-pi)
         * [2. Get Docker image](#2-get-docker-image)
         * [3. Run](#3-run)
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
<a href="https://github.com/lomorage/pi-gen/releases/download/2020_04_24.21_33_24.0.1d48693/image_2020-04-24-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

After you download the customized OS image, you can install the image to MicroSD card using [balenaEtcher](https://www.balena.io/etcher/), which is available on both Windows and macOS.

After you insert the MicroSD to your desktop or laptop, just select the image you download, choose the MicroSD drive, and click "Flash", it will be done in a few minutes.

<p align="center">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>

After flushing the image, insert the microSD into Raspberry Pi board, connect USB hard drive with Raspberry Pi, plug in a network cable, plug in the power supply, turn on the power and wait a few minutes for system boot.

If you have HDMI connected, after system boot successfully, it will show up a screen that no able to find any assets. You can upload photos using Lomorage Phone app, and then press "r" to rescan. If you want to quit to terminal to do some configuration, just press "ESC" and then "Ctrl+Alt+F2", after you made any changes and want to start lomo-frame, use command `sudo service supervisor restart`.

*The default login username is "pi" and password is "raspberry"*

We suggest use cable to provide better performance, but if you prefer to use WiFi, you can login Raspberry Pi and use the command `wifi_switch.sh client "wifi-ssid" wifi-password`, replace "wifi-ssid" and "wifi-password" with those of your wifi network. *Make sure you have quotation mark around "wifi-ssid" if you have space or unicode character in it, for example `wifi_switch.sh client "Lomorage's 2.4G" mypassword`.*

## Docker installation

Docker installation is convenient way if you don't want to mess thing on existing system. It doesn't support Raspberry Pi 0 and 1 now.

**MDNS won't work in this case, so the service won't be discovered automatically on Lomorage Phone APP, you have to enter the service IP address and Port manually**

Docker image includes:

- lomo-backend: Lomorage service backend

- lomo-web: Lomorage web application

### 1. Install Docker on Raspberry Pi

*note: If you are using OMSC, you need to change "id=osmc" in “/etc/os-release” to "id=raspbain"*

```
sudo apt install -y ca-certificates
sudo update-ca-certificates --fresh
curl -fSLs https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
sudo systemctl start docker
```

### 2. Get Docker image

Pull from docker hub.

```
sudo docker pull lomorage/raspberrypi-lomorage:latest
```

### 3. Run

Download [run.sh](https://raw.githubusercontent.com/lomorage/lomo-docker/master/run.sh).

You can specify the media home directory and lomo directory, otherwise it will use the default, you MUST specify the host.

There should be subdirectories in media home directory，for example if you specify `-m /mnt/hdd/`, then there should be some subdirectory in hdd, like `-m /mnt/hdd/lomorage`.

```
run.sh [-m {media-dir} -b {lomo-dir} -d -p {lomod-port} -P {lomow-port}] -h host-ip -i image-name

Command line options:
    -m  DIR         Absolute path of media directory used for media assets, default to $HOME_MEDIA_DIR, optional
    -b  DIR         Absolute path of lomo directory used for db and log files, default to $HOME_LOMO_DIR, optional
    -h  HOST        IP address or hostname of the host machine, required
    -p  LOMOD_PORT  lomo-backend service port exposed on host machine, default to $LOMOD_HOST_PORT, optional
    -P  LOMOW_PORT  lomo-web service port exposed on host machine, default to $LOMOW_HOST_PORT, optional
    -i  IMAGE_NAME  docker image name, for example "lomorage/raspberrypi-lomorage:[tag]", required
    -d              Debug mode to run in foreground, default to $DEBUG, optional

Examples:
    # assuming your hard drive mounted in /media, like /media/usb0, /media/usb1.
    ./run.sh -m /media -b /home/pi/lomorage -h 192.168.1.232
```

You can add the command in "/etc/rc.local" before "exit 0" to make it run automatically after system boot.

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

If your username is not "pi", you need to change "User=pi" in "/lib/systemd/system/lomod.service", and use your username.

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
