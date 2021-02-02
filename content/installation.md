+++
title = "Installation Guide"
+++

# Installation Guide

## 1. Overview

To use Lomorage, you need to run the Lomorage service in your local network, either on Windows, OSX or Raspberry Pi. And then you need to download the client APP at the APP store. Once you run the Lomorage service, the client APP is supposed to find the service running automatically with zero configuration, then you can upload photos on the Phone.

## 2. Install Lomorage Service

The first step is to set up the Lomorage service.

**You can choose which version of Lomorage Service to download based on your preference**. Running Lomorage service on Windows or OSX gives you better performance compared with on Raspberry Pi, the uploading and accessing the backup will be faster, but running Windows or OSX is not energy efficient as using Raspberry Pi. If using Raspberry Pi, you don't need to worry about the electricity bill, it is only [about 5$ a year](https://raspberrypi.stackexchange.com/questions/5033/how-much-energy-does-the-raspberry-pi-consume-in-a-day)

<p align="center">
<a href="/installation-win" title="Install Lomorage service on Windows" class="badge windows">Windows</a>
&nbsp;
<a href="/installation-osx" title="Install Lomorage service on macOS" class="badge">macOS</a>
&nbsp;
<a href="/installation-pi" title="Install Lomorage service on Raspberry Pi" class="badge raspberrypi">Raspbian</a>
&nbsp;
<a href="/installation-docker" title="Install Lomorage service using Docker" class="badge docker">Docker</a>
&nbsp;
<a href="/installation-armbian" title="Install Lomorage service on Armbian" class="badge armbian">Armbian</a>
&nbsp;
<a href="/installation-ubuntu" title="Install Lomorage service on Ubuntu" class="badge ubuntu">Ubuntu</a>
</p>


## 3. Install Lomorage Client

After running Lomorage Service, you can then install Lomorage client on smart phone.

You can also use the web client to upload assets on your desktop/laptop, or use it to browser the photo/video gallery.


<p align="center">
<a href="/installation-android"><img alt="Download Android client" src="/img/installation/app-store-google.svg" width="220"></a>
<a href="/installation-ios"><img alt="Lomorage iOS client" src="/img/installation/app-store-ios.svg" width="220"></a>
&nbsp;
<a href="/installation-web"><img alt="Lomorage web client" src="/img/installation/browser.png" width="220"></a>
</p>

## 4. External Access (optional)

Lomorage can run within your private network with no Internet access, but if you want to access Lomorage from outside, then you can enable the external access, currently it support free 3rd party tunnel services. Check the [configuration](/external-access) for external access.

## 5. Setup Digital Frame (optional)

You can connect monitor with Raspberry Pi and use that as digital photo frame, and you can setup multiple digital photo frames using Raspberry Pi zero w and access your digital assets via WiFi. Check [here](/install-frame) for digital frame setup instructions. 

<br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"             title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
