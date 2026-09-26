---
title: Synology
weight: 6
---

# Synology

## 1. Search lomorage from docker registry

Once lomorage image is found, you can also click `Download` icon to download the docker image. There are arm and amd64 version, please download correct one based on your host arch.

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology1.png">
</p>

## 2. Launch lomorage container

Go to Image tab, select downloaded lomorage container, click `Launch` icon

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology2.png">
</p>

## 3. Advanced settings

Set name for new container, and click `Advanced Setting` button

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology3.png">
</p>

### 3.1. Enable auto-restart

Check the auto-restart box to make sure lomorage can be auto-started

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology4.png">
</p>

### 3.2. Volume setting

At volume tab page, click `Add Folder`, then create lomorage folder under `docker` and two new sub folders:
 - data: store photo/video data files. The folder should be mounted to `/media` directory inside container.
 - app:  store app logs, configuration, etc files. The folder should be mounted to `/lomo` directory inside container.

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology5.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology6.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology7.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology8.png">
</p>

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology9.png">
</p>

### 3.3. Port settings

At port setting tab page, add new tcp port mapping 8000 -> 8000

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology10.png">
</p>

## 4. Done

Click `Apply` button, and lomorage container should start running now, and you can visit the app from mobile clients.

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology11.png">
</p>

## 5. MAC vlan docker network

Previous steps uses default docker bridge network, thus, user need manually input client ip from mobile client. To enable MDNS feature, user can setup mac vlan docker network, and associate it with the container, then mobile client can auto discover lomorage app.

To create mac vlan network, please make sure you have subnet, gateway, interface name and new static ip for lomorage container. Assume they are
 - subnet: 192.168.1.0/24
 - gateway: 192.168.1.1
 - interface name: eth0
 - new static ip: 192.168.1.100

Use ssh to login Synology, and run `docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 --ip-range=192.168.1.100/32 -o parent=eth0 lomorage` to create lomorage network. After that, if you run `docker network ls`, you should see the new docker network

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology12.png">
</p>

Go to Synology docker web page, click `Network` tab from sidebar, the `lomorage` network should show up now.

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology13.png">
</p>

Stop running lomorage container, click `Edit` button. In `Network` tab page, add new `lomorage` network, and remove `bridge` network, then click apply, and start container. Now your mobile client should be able to auto discover the backend application.

<p align="center">
  <img style="max-width:100%; object-fit: contain;" src="/img/installation/synology14.png">
</p>
