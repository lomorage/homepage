+++
title = "PhotoPrism:开源的智能AI照片视频管理工具"
tags = ["Lomorage", "PhotoPrism", "AI相册"]
categories = ["AI相册"]
date = "2022-02-11 10:38:00"
banner = "img/blog/photoprism/photoprism-banner.jpeg"
+++

PhotoPrism是一款开源的智能AI照片视频管理工具，能非常好的搭配Lomorage使用。

<!--more--> 

![PhotoPrism Screenshot](https://camo.githubusercontent.com/5e03a87e47aad26ad7248b8b43eac6471fe96f7b655ac2e532697692753c3ff8/68747470733a2f2f646c2e70686f746f707269736d2e6170702f696d672f75692f6465736b746f702d3130303070782e6a7067)

- 强大的搜索功能，可以按人，地点，物体和色彩来搜索

- 高精度的地图模式

- 人脸识别

- 自动基于图片内容和地点的自动分类

- 提取并索引照片视频中的元信息(EXIF/XMP)

PhotoPrism有个demo站点，大家可以试试，[https://demo-zh.photoprism.app/browse](https://demo-zh.photoprism.app/browse)。

PhotoPrism现在比较成熟的是Web应用，手机端的[应用](https://github.com/thielepaul/photoprism-mobile)由第三方开发，还不太成熟，现在还在测试阶段，并且涉及到服务端API的[改动](https://github.com/photoprism/photoprism/pull/995)还没有合并到主干代码仓库中，官方说精力不够，还没有时间来做代码审查。

对于想把手机同步备份到PhotoPrism的用户，官方推荐的是用[PhotoSync](https://www.photosync-app.com/home.html)，但PhotoSync如果要原始尺寸备份是需要[收费](https://www.photosync-app.com/support/ios/answers/what-is-the-difference-between-photosync-pro-and-premium.html)的，Pro版本的是40块一次性购买，Premium版本是45块一年，或者6块一个月，或者163块一次性购买。对于一般手机照片备份的场景，Pro版本就够用了。[Lomorage](https://lomorage.com)现在除了云端备份不支持外，其他Pro版本的功能都有了，0成本，而且Lomorage也能和Photoprism完美整合，下面的步骤就一步步的演示如何在**树莓派4**上安装配置PhotoPrism，因为PhotoPrism是基于Docker容器的部署安装，其他的平台安装方法也是类似的，大家可以参考[官方文档](https://docs.photoprism.app/getting-started/docker-compose/)。

## 1. 安装Docker

```
$ sudo apt install -y ca-certificates
$ sudo update-ca-certificates --fresh
$ curl -fSLs https://get.docker.com | sudo sh
$ sudo usermod -aG docker $USER
$ sudo systemctl start docker
$ sudo docker info
```

## 2. 安装Docker-Compose

```
$ sudo apt-get install libffi-dev libssl-dev
$ sudo apt install python3-dev
$ sudo apt-get install -y python3 python3-pip
$ sudo pip3 install docker-compose
```

## 3. 下载PhotoPrism的yaml配置文件

如果使用64位系统:

```
$ mkdir ~/photoprism
$ wget https://dl.photoprism.app/docker/arm64/docker-compose.yml -O ~/photoprism/docker-compose.yml
```

如果使用32位系统:

```
$ mkdir ~/photoprism
$ wget https://dl.photoprism.app/docker/armv7/docker-compose.yml -O ~/photoprism/docker-compose.yml
```

## 4. 修改配置文件

修改docker-compose.yml中的配置项。

如果需要使用密码验证，可以修改密码，用户名是admin。

```
PHOTOPRISM_ADMIN_PASSWORD: "insecure"          # !!! PLEASE CHANGE YOUR INITIAL "admin" PASSWORD !!!
```

如果不需要验证，`PHOTOPRISM_PUBLIC`直接改成"true"禁用即可。

```
PHOTOPRISM_PUBLIC: "true"                     # no authentication required, disables password protection
```

修改访问地址，将`PHOTOPRISM_SITE_URL`中的"localhost"替换为树莓派的ip地址，端口2342不用改。

```
PHOTOPRISM_SITE_URL: "http://localhost:2342/"  # public server URL incl http:// or https:// and /path, :port is optional
```

如果需要改端口，除了修改上面的默认的2342端口，还要修改ports的映射:

```
    ports:
      - "2342:2342" # HTTP port (host:container)
```

比如2342修改为80，如果树莓派ip地址是192.168.1.100那需要修改为:

```
    ports:
      - "80:2342" # HTTP port (host:container)
    environment:
      PHOTOPRISM_SITE_URL: "http://192.168.1.100:80/"
```

对于使用Lomorage进行照片备份，并配合PhotoPrism进行索引的，只需要修改映射目录即可，下面的例子磁盘挂载在"/media/WD_90C27F73C27F5C82"目录下，Lomorage系统有bob和alice两个用户，我们把目录设置到了master这一个层级，这样就不会索引preview目录了，映射到docker里面的目录必须是在"/photoprism/originals"下面。

PhotoPrism分析照片视频的会生成一些缓存和缩略图，元数据文件等，需要额外的目录来存储，下面的例子中创建了"photoprismStorage"目录。

```
    volumes:
      ## The *originals* folder contains your original photo and video files (- "[host folder]:/photoprism/originals"):
      - "/media/WD_90C27F73C27F5C82/bob/Photos/master/:/photoprism/originals/bob"
      - "/media/WD_90C27F73C27F5C82/alice/Photos/master/:/photoprism/originals/alice"
      ## Cache, session, thumbnail, and sidecar files will be created in the *storage* folder (never remove):
      - "/media/WD_90C27F73C27F5C82/photoprismStorage:/photoprism/storage"
```

最后，我们设置`PHOTOPRISM_READONLY`为"true"，确保我们的原始的Lomorage数据目录不被修改。

```
PHOTOPRISM_READONLY: "true"                   # don't modify originals folder; disables import, upload, and delete
```

数据库使用sqlite也够用了，去掉默认的，设置为空""即可.

```
      PHOTOPRISM_DATABASE_DRIVER: ""            # use MariaDB 10.5+ or MySQL 8+ instead of SQLite for improved performance
```

## 5. 启动PhotoPrism

执行下面的命令，会花一些时间下载PhotoPrism镜像，然后启动应用。

```
$ docker-compose up -d
```

启动完成后，访问http://[your-raspberrypi-ip]:2342，点击左侧栏的[Library菜单](https://demo.photoprism.app/library)，打开索引设置，点击Start按钮开始索引，构建索引会花点时间，索引过程中也可以使用PhotoPrism浏览已经扫描过的照片。PhotoPrism中文支持的不错，打开Setting菜单，可以修改语言为中文。

如果我们想让每天自动构建索引，无需人工触发，可以通过cronjob，创建/etc/cron.daily/photoprism-index，输入如下内容，其中`/home/pi/photoprism`为前面的配置文件所在路径。

```
#!/bin/sh
cd /home/pi/photoprism && docker-compose exec -T photoprism photoprism index
```

添加可执行权限:

```
$ sudo chomd +x /etc/cron.daily/photoprism-index
```

到此为止，PhotoPrism的安装配置就完成了，可以通过电脑或手机浏览器使用PhotoPrism。

如果您在安装过程中碰到什么问题，欢迎和我们联系。