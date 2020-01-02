+++
title = "树莓派设置冗余备份"
tags = ["树莓派", "冗余备份", "硬盘", "U盘", "USB分线器", "恢复"]
categories = ["FAQ"]
date = "2019-12-24T13:43:40"
banner = "img/banners/power-hub-adafruit.jpg"
+++

珍贵的照片和视频仅仅保存一份是不够的，我们至少需要保存两份，最好还能有一个远程的备份。Lomorage当前提供了冗余备份的功能。可以有下面的几种方式来设置冗余备份。

<!--more--> 

目录
=================

   * [树莓派设置冗余备份](#树莓派设置冗余备份)
      * [方案1 (1个USB硬盘, 1个U盘, 使用同一个树莓派)](#方案1-1个usb硬盘-1个u盘-使用同一个树莓派)
      * [方案2 (2个USB硬盘, 使用同一个树莓派)](#方案2-2个usb硬盘-使用同一个树莓派)
      * [方案3 (2个USB硬盘分别运行在2个树莓派上)](#方案3-2个usb硬盘分别运行在2个树莓派上)
      * [方案4 (1个USB硬盘连接一个树莓派, NAS存储)](#方案4-1个usb硬盘连接一个树莓派-nas存储)
   * [从备份恢复](#从备份恢复)

# 树莓派设置冗余备份

您可以更加自己的需求来选择合适的方案。

## 方案1 (1个USB硬盘, 1个U盘, 使用同一个树莓派)

树莓派可以带一块USB 2.5存移动硬盘，再加一个U盘应该也没问题。但是通常硬盘比U盘的[寿命更久](https://www.datanumen.com/blogs/usb-flash-drive-vs-external-hard-drive-better-storing-data/)，U盘的[擦写次数有限](https://www.flashbay.com/blog/usb-life-expectancy)，最好使用移动硬盘作为主备，U盘作为从备。

## 方案2 (2个USB硬盘, 使用同一个树莓派)

通常树莓派带不动两块硬盘，您需要购买一个带供电功能的USB分线器，这样两块硬盘都可以用USB分线器来供电。

- [绿联usb分线器](https://detail.tmall.com/item.htm?id=562288776006&ali_refid=a3_430620_1006:1151650521:N:aiqAvS76BytC0lZdUjIxdVOFAYSqPokT:713f58932d42a12bf6bd56654385f5fc&ali_trackid=1_713f58932d42a12bf6bd56654385f5fc&spm=a230r.1.14.1&sku_properties=148242406:21516)

## 方案3 (2个USB硬盘分别运行在2个树莓派上)

两套环境运行在不同的地方可能会更加安全，Lomorage定制的系统镜像默认是已经开启了Samba文件共享服务，您可以将第二套环境里面的硬盘直接通过Samba方式，网络加载到第一套环境。

比如，第二个树莓派的ip是"192.168.1.155"，硬盘加载到"/media/WD_90C27F73C27F5C82"目录。

在第一个树莓派上，可以使用下面的命令加载第二个树莓派上连接的硬盘（请将ip和加载目录修改为您自己环境里的配置）：

```
mkdir /media/WD_90C27F73C27F5C82

# user pass is the username password on 2nd Pi, that is the default.
# uid 1000 and gid 1000 is for mount it as user Pi on 1st Pi
sudo mount.cifs //192.168.1.155/media/WD_90C27F73C27F5C82 /media/WD_90C27F73C27F5C82 -o user=pi,pass=raspberry,uid=1000,gid=1000
```

您也可以添加新条目到"/etc/fstab", 这样下次系统启动的时候也能自动加载Samba网络存储:

```
//192.168.1.155/media/WD_90C27F73C27F5C82  /media/WD_90C27F73C27F5C82  cifs  user=pi,pass=raspberry,uid=1000,gid=1000
```

修改完后，您可以使用下面的命令来测试加载是否成功:

```
sudo mount -a
sudo umount -a
```

**注意: 即使第二个树莓派能自动发现，也不要在iOS App使用它，因为我们使用第一个主树莓派环境，并设置冗余备份到通过Samba方式加载的第二块树莓派连接的硬盘。当前我们不支持通过APP操作改方案，需要通过命令行方式，后续我们会添加通过APP操作的方式**

## 方案4 (1个USB硬盘连接一个树莓派, NAS存储)

您可以使用您的NAS存储来做冗余备份，步骤和上面的方案3类似，通过Samba加载NAS存储。

用到的参数如下:

- Samba服务地址 (如：192.168.1.155)

- Samba共享目录名 (如：WD_90C27F73C27F5C82)

- 树莓派硬盘加载目录 (如果使用Lomorage定制OS镜像，加载目录路径是"/media"；如果您的加载目录路径是其他的，您可以使用"--mount-dir"命令行参数来运行lomod)

- Samba服务的用户名和密码

# 从备份恢复

如果您的主备硬盘不幸坏掉来，您可以使用从备份来恢复。所有的文件包括照片视频和数据库都会备份，您可以从用户目录下拷贝"assets.db"到"/opt/lomorage/var/assets.db"目录下，并修改"assets.db"中"user"表，将"home_dir"设置为您新的磁盘加载路径。我们后续会让恢复功能更容易使用，但现在您只能手工操作，如果您碰到问题不能解决，可以加入我们的[slack channel](https://join.slack.com/t/lomorage/shared_invite/enQtODc4MTE5ODQzNzkyLTRlY2U4MTQ1YjczYjBhMDcwMmExYTUxNTg2NTE5YmRkZjg2ZWQwZjg1MjEwMjQzZWVjMmEwZjk3ZGIyODY4ODM)或者[邮件](mailto: support@lomorage.com)联系我们帮您解决。
