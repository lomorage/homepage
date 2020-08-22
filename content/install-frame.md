Table of Contents
=================

   * [Install lomo-frame](#install-lomo-frame)
   * [Setup lomo-frame](#setup-lomo-frame)
      * [Quickstart](#quickstart)
      * [Turn Frame ON/OFF](#turn-frame-onoff)
      * [Stop/Start lomo-frame Service](#stop-or-start-lomo-frame-service)
      * [Schedule Frame ON/OFF time](#schedule-frame-onoff-time)
      * [Playback Order](#playback-order)
      * [Customize playlist](#customize-playlist)
      * [Playback Media Type](#playback-media-type)
      * [Keyboard control](#keyboard-control)
      * [Setup multiple digital frame](#setup-multiple-digital-frame)
         * [1. Install lomo-frame](#1-install-lomo-frame)
         * [2. Setup WiFi connection](#2-setup-wifi-connection)
         * [3. Check IP address of primary Raspberry Pi](#3-check-ip-address-of-primary-raspberry-pi)
         * [4. Find the mount directory on primary Raspberry Pi](#4-find-the-mount-directory-on-primary-raspberry-pi)
         * [5. Mount on Raspberry Pi zero w](#5-mount-on-raspberry-pi-zero-w)
         * [6. Reboot](#6-reboot)

# Install lomo-frame

**If you install the latest Lomorage Raspberry Pi OS image, you should already have the lomo-frame application installed in that image.**

Otherwise, if your OS image is before 2020-03-13 ("image_2020-03-13-lomorage-lite.zip
"), or you don't use Lomorage Raspberry Pi OS image, you can run the following command to install it (assuming you have installed Lomorage Service Application so that you have already added "gpg.key", if not you can check [here](/installation-pi)).

```
sudo apt update
sudo apt install lomo-frame
```

# Setup lomo-frame

**Lomorage Digital Frame is still in beta, and setup MAY need you connect keyboard to Raspberry Pi, or you can use ssh to access Raspberry Pi, sorry, we promise that you will be able to control and setup via phone APP later.**

## Quickstart

If you have lomo-frame installed, it will launch on boot.

At first launch, it will scan all the digital assets in "/media" directories, which means all users photo and video will be scanned, and will generate playlist in "/opt/lomorage/var/lomo-playlist.txt". 

**The rescan is schedule to run automatically on weekly basis (00:00 on Sunday)**, so that the playlist can be updated with newly added or deleted assets. You can manually trigger the rescan in two ways:

1. If you have keyboard connected with Raspberry Pi, press key "r" to rescan.

2. If you are using ssh to access Raspberry Pi, you can use `framectrl.sh rescan` to rescan.

## Turn Frame ON/OFF

lomo-frame will start after system boot automatically, but if you want manual control, you can use the following commands to turn it on: `framectrl.sh on`, or turn it off: `framectrl.sh off`. **It will turn on/off the monitor as well as the lomo-frame service.**

## Stop or Start lomo-frame Service

If you just want to quit lomo-frame service, while keep the monitor on, you can either:

 - press "esc" on the keyboard if Raspberry Pi connected with keyboard.

 - `sudo service supervisor stop` if you use ssh to access Raspberry Pi.

You can use `sudo service supervisor start` to start the lomo-frame serivce.

## Schedule Frame ON/OFF time

**The default turn on time is "08:00 am", and turn off time is "21:00 pm".**

You can change that use the following command, which changes the on time to "10:00 am" and off time to "18:00":

```
framectr.sh add --on-hour 10 --off-hour 18
```

You can also change that to "10:30 am" and off time to "18:30"

```
framectr.sh add --on-hour 10 --on-min 30 --off-hour 18 --off-min 30
```

Or if you want to keep it on 7x24, just remove the schedule:

```
framectr.sh remove
```

## Playback Order

**By default, it's random**, but if you prefer to playback sequentially:

```
sudo sed -i "s/is_random =.*/is_random = false/" /opt/lomorage/var/video_looper.ini
```

Or you can change it back to random:

```
sudo sed -i "s/is_random =.*/is_random = true/" /opt/lomorage/var/video_looper.ini
```

## Customize playlist

You can edit/create "/opt/lomorage/var/lomo-playlist.txt", the format is one media file path per line.

## Playback Media Type

**By default, it will play videos and images**, but if you need to play only images, you can change the "media_type" in "/opt/lomorage/var/video_looper.ini":

```
sudo sed -i "s/media_type =.*/media_type = image/" /opt/lomorage/var/video_looper.ini
```

or play only video:

```
sudo sed -i "s/media_type =.*/media_type = video/" /opt/lomorage/var/video_looper.ini
```

or restore to play all media assets:

```
sudo sed -i "s/media_type =.*/media_type = all/" /opt/lomorage/var/video_looper.ini
```

## Keyboard control

If you have keyboard connect with Raspberry Pi, you can press the following key to control:

  - "r": rescan playlist.

  - "k": skip to next.

  - "s": pause/resume play

  - "esc": quit lomo-frame

## Setup multiple digital frame

This setup need some expertise, sorry, will make it easier in the future using phone APP.

If you already have one Raspberry Pi (Primary Raspberry Pi) setup for running Lomorage service, and having all the hard drivers connected with that device, you probably keep it in the storage room connected to the router with wired network, and want to setup the digital frame in bedroom or living room.

You can use a low cost Raspberry Pi zero w to setup the digital frame and access your digital assets via WiFi, it works pretty well, the video playback is very smooth.

### 1. Install lomo-frame

You can follow the instructions on the top of the page.

### 2. Setup WiFi connection

Connect keyboard with Raspberry Pi zero W and login, if you installed Lomorage Raspberry Pi OS image, you can use the command `wifi_switch client [wifi-ssid] [wifi-password]`, replace "[wifi-ssid]" and "[wifi-password]" with those of your wifi network; otherwise, you can refer to other docs online to set the WiFi connection.

### 3. Check IP address of primary Raspberry Pi

You can find the IP address using iPhone APP, in "settings" tab, section "LOCAL SERVICE", the host field is the IP address.

### 4. Find the mount directory on primary Raspberry Pi

You can mount the "media" directory on primary Raspberry Pi onto your desktop/laptop via SAMBA, with user name "pi" and password "raspberry", and you will find the directory name store media assets mounted under "media" directory.

### 5. Mount on Raspberry Pi zero w

Say if directory with name "/media/WD_90C27F73C27F5C82" store media assets mounted on primary Raspberry Pi (with IP 192.168.1.155), you can mount it on your Raspberry Pi zero w, login to Raspberry Pi zero and then:

```
sudo mkdir /media/WD_90C27F73C27F5C82
echo "//192.168.1.124/media/WD_90C27F73C27F5C82  /media/WD_90C27F73C27F5C82  cifs  user=pi,pass=raspberry,uid=1000,gid=1000" | sudo tee -a /etc/fstab
sudo mount -a
```

### 6. Reboot

```
sudo reboot
```

After reboot, you should be able to see it starts scanning the media files to generate playlist.