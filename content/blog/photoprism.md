+++
title = "PhotoPrism meets Lomorage: The best Google Photos alternative"
tags = ["Lomorage", "PhotoPrism", "AI"]
categories = ["AI"]
date = "2022-02-11 10:38:00"
banner = "img/blog/photoprism/photoprism-banner.jpeg"
+++

PhotoPrism is an Open Source AI Photo Management tool, and it works very well along with Lomorage.

<!--more-->

![PhotoPrism Screenshot](https://camo.githubusercontent.com/5e03a87e47aad26ad7248b8b43eac6471fe96f7b655ac2e532697692753c3ff8/68747470733a2f2f646c2e70686f746f707269736d2e6170702f696d672f75692f6465736b746f702d3130303070782e6a7067)

- Powerful search, by people, location, objects and color.

- high precision world map.

- Face recognition.

- categorize by photo content and location automatically.

- Extract metadata (EXIF/XMP) from photo/video and build index.

PhotoPrism has a demo site you can try it out [https://demo-zh.photoprism.app/browse](https://demo-zh.photoprism.app/browse).

PhotoPrism has mature Web App, however the [mobile APP](https://github.com/thielepaul/photoprism-mobile) is developed by 3rd party, and it's not ready yet, still in beta testing, and the [API changes]((https://github.com/photoprism/photoprism/pull/995)) on server is not merged yet, the official developer doesn't have resource to review the code yet.

For those who would like to upload their photo to PhotoPrism, the official suggestion is to use [PhotoSync](https://www.photosync-app.com/home.html), however PhotoSync will charge you on [backup the original size](https://www.photosync-app.com/support/ios/answers/what-is-the-difference-between-photosync-pro-and-premium.html). [Lomorage](https://lomorage.com) can be a very good alternative for this without charing anything. The following steps will show you how to install and configure Photoprism to work with Lomorage, it's installed on **Raspberry Pi 4**, but you can install PhotoPrism on other platforms because it's deployed via Docker, and you can refer to [official documentation](https://docs.photoprism.app/getting-started/docker-compose/), and Lomorage is cross platform as well.

## 1. Install Docker

```
$ sudo apt install -y ca-certificates
$ sudo update-ca-certificates --fresh
$ curl -fSLs https://get.docker.com | sudo sh
$ sudo usermod -aG docker $USER
$ sudo systemctl start docker
$ sudo docker info
```

## 2. Install Docker-Compose

```
$ sudo apt-get install libffi-dev libssl-dev
$ sudo apt install python3-dev
$ sudo apt-get install -y python3 python3-pip
$ sudo pip3 install docker-compose
```

## 3. Download PhotoPrism yaml configure file

If using 64 bits OS:

```
$ mkdir ~/photoprism
$ wget https://dl.photoprism.app/docker/arm64/docker-compose.yml -O ~/photoprism/docker-compose.yml
```

If using 32 bits OS:

```
$ mkdir ~/photoprism
$ wget https://dl.photoprism.app/docker/armv7/docker-compose.yml -O ~/photoprism/docker-compose.yml
```

## 4. Change configuration

Modify the following config items in docker-compose.yml。

If you want to enable authentication, you can change the password for user "admin". (*PhotoPrism currently doesn't support multi-users*)

```
PHOTOPRISM_ADMIN_PASSWORD: "insecure"          # !!! PLEASE CHANGE YOUR INITIAL "admin" PASSWORD !!!
```

If you don't need authentication，just change `PHOTOPRISM_PUBLIC` to "true".

```
PHOTOPRISM_PUBLIC: "true"                     # no authentication required, disables password protection
```

Change "localhost" in `PHOTOPRISM_SITE_URL` to IP address of Raspberry Pi.

```
PHOTOPRISM_SITE_URL: "http://localhost:2342/"  # public server URL incl http:// or https:// and /path, :port is optional
```

If you want to change the listen port, besides changing "2342" in `PHOTOPRISM_SITE_URL`, you need to change ports mapping as well:

```
    ports:
      - "2342:2342" # HTTP port (host:container)
```

For example, if you want to change port form 2342 to 80，assuming IP Address of Raspberry Pi is 192.168.1.100, then change as below:

```
    ports:
      - "80:2342" # HTTP port (host:container)
    environment:
      PHOTOPRISM_SITE_URL: "http://192.168.1.100:80/"
```

If using Lomorage for photo backup, and you can config PhotoPrism to index the photos. You just need to change the directory mapping, in example below, the disk is mounted at "/media/WD_90C27F73C27F5C82", and Lomorage has two users, bob and alice, we can just configure the directory mapping to "master" level so that it won't indexing the thumbnails in preview, the destination directory should be in "/photoprism/originals".

PhotoPrism will analyze photos/videos and generate cache, thumbnails and metadata files, and need extra room for those. In example below, it creates folder "photoprismStorage" on host。

```
    volumes:
      ## The *originals* folder contains your original photo and video files (- "[host folder]:/photoprism/originals"):
      - "/media/WD_90C27F73C27F5C82/bob/Photos/master/:/photoprism/originals/bob"
      - "/media/WD_90C27F73C27F5C82/alice/Photos/master/:/photoprism/originals/alice"
      ## Cache, session, thumbnail, and sidecar files will be created in the *storage* folder (never remove):
      - "/media/WD_90C27F73C27F5C82/photoprismStorage:/photoprism/storage"
```

In the last, we configure `PHOTOPRISM_READONLY` to "true", just to makes sure the original folders in Lomorage won't be modified.

```
PHOTOPRISM_READONLY: "true"                   # don't modify originals folder; disables import, upload, and delete
```

You can use sqlite as the database engine, and remove the default and just leave it blank.

```
      PHOTOPRISM_DATABASE_DRIVER: ""            # use MariaDB 10.5+ or MySQL 8+ instead of SQLite for improved performance
```

## 5. Start PhotoPrism

Run following command, it will take a while to pull the image and run it.

```
$ docker-compose up -d
```

Once done, you can access http://[your-raspberrypi-ip]:2342，click [Library](https://demo.photoprism.app/library) on the left side bar, and open indexing configuration page, and click Start button to start indexing, it will take a while, and you can browser those already indexed photos at the same time. You can change language settings as well.

If you need to index automatically without manual trigger, you can create cronjob, create file /etc/cron.daily/photoprism-index, and input following content, `/home/pi/photoprism` is the place where the configuration file locates.

```
#!/bin/sh
cd /home/pi/photoprism && docker-compose exec -T photoprism photoprism index
```

add executable permission:

```
$ sudo chomd +x /etc/cron.daily/photoprism-index
```

Now, we've finished PhotoPrism installation and configuration, and you can use browser to use PhotoPrism on PC or smart phone.

Let's us know if you have any issues with the above steps, and we are ready to help.
