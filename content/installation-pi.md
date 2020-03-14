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

**There are two options to install Lomorage service on Raspberry Pi**, one is using the prebuild OS image which has all the dependencies installed, another one is manaully installation if you already have Raspberry Pi setup and running for other purpose.

## Install with prebuild OS image

Click the link below to download the prebuild OS image.

<p align="center">
<a href="https://github.com/lomorage/pi-gen/releases/download/2020_03_13.10_54_31.0.60425d1/image_2020-03-13-lomorage-lite.zip" title="Install Lomorage for Raspberry Pi" class="badge raspberrypi">Raspberry Pi</a>
</p>

After you download the customized OS image, you can install the image to MicroSD card using [balenaEtcher](https://www.balena.io/etcher/), which is available on both Windows and macOS.

After you insert the MicroSD to your desktop or laptop, just select the image you download, choose the MicroSD drive, and click "Flash", it will be done in a few minutes.

<p align="center">
  <img width="50%" src="/img/installation/balenaEtcher.png">
</p>

After flushing the image, insert the microSD into Raspberry Pi board, connect USB hard drive with Raspberry Pi, plug in a network cable, plug in the power supply, turn on the power and wait a few minutes for system boot.

We strongely suggest use cable to provide better performance, but if you prefer to use WiFi, you can login Raspberry Pi and use the command `wifi_switch client [wifi-ssid] [wifi-password]`, replace "[wifi-ssid]" and "[wifi-password]" with those of your wifi network.

*The login username is "pi" and password is "raspberry"*

## Install on existing Raspbian

**step 1. Add lomoware source**

```
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

**step 2. Install 3rd party tools**

```
sudo apt install ffmpeg rsync jq libimage-exiftool-perl -y
```

**step 3. Install file systems support**

```
sudo apt install nfs-common exfat-fuse ntfs-3g hfsplus hfsutils hfsprogs -y
sudo ln -nsf /bin/ntfsfix /sbin/fsck.ntfs
sudo ln -nsf /bin/ntfsfix /sbin/fsck.ntfs-3g
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

**step 6. Change mount directory and username if needed**

If you are not using the usbmount in step 4, you may need to specify the mount directory if the USB drive is not mounted in "/media" directory. 

For example if you are using PCManFM, then the mount directory will be "/media/pi". To specify the mount directory to be "/media/pi", modify `ExecStart` in "lib/systemd/system/lomod.service", and add paramter "--mount-dir" as below

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir /media/pi  --max-upload 1 --max-fetch-preview 3
```

If your username is not "pi", you need to change "User=pi" in "lib/systemd/system/lomod.service", and use your username.

Then restart Lomorage service:

```
sudo systemctl restart lomod
```
