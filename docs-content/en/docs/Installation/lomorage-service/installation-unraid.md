---
title: Unraid
weight: 6
---

# Unraid

## 1. Search lomorage from app store

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid1.png">
</p>

Once lomorage is found, you can also click `info` icon to learn more about lomorage support at unraid forum

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid2.png">
</p>

## 2. Click install. You are done!

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid3.png">
</p>

## Unraid template customization
Below is the explanation on template configuration.

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid4.png">
</p>

- Network: Default value is `host` mode because mobile client uses MDNS to auto-discover "Lomorage Photo Assistant" listen address and port. It can be changed to `bridge` mode if user wants to configure these information from mobile client by yourselves.
- ExtraParams: Default value is `99:100`. This parameter need combined together with `User` mount configuration. It is to make sure uploaded photos/videos have right user/group permission, and can be browsed via unraid share feature. 99 is user ID of `nobody`, and 100 is group ID of `nobody`. User can customize it based on his own user configuration.
- PostArgs: Default value is `8000` which is Lomorage API backend listening port
- Config
  * MediaDir: This is uploaded media storage directory. Default value is `/mnt/user/`
  * AppDir: This directory stores configuration file, database file, log files, etc, used by "Lomorage Photo Assistant". Default value is `/mnt/user/appdata`
  * User: This mount file is to ensure "Lomorage Photo Assistant" uses the same user ID and group ID as host unraid OS. Lomorage will never read the confidential data inside the file

## Nginx Proxy Manager integration
Nginx Proxy Manager is a popular self-host tool to easily forward your websites running at home to the public internet. It has one official app on Unraid community, and user can install by their own.

1. Click `Add Proxy Host`, then set your own domain name and forward ip as below screen. Schema is `http`, and forward port is the listen port configured for Lomorage container, 8000 is default listen port.

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/npm1.png">
</p>

2. Enable `SSL` configuration and set certificate domain name as your own domain name

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/npm2.png">
</p>

3. Click `Save`, and below host should be added into the host list

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/npm3.png">
</p>
