---
title: openSUSE Leap
weight: 9
---

# 在openSUSE Leap上安装"Lomorage照片助手"

**当前我们只支持x86/AMD64 openSUSE Leap（当前发行版）。**

## 1. 安装lomoware源

```bash
sudo zypper addrepo --refresh https://lomoware.lomorage.com/rpm/opensuse/lomoware.repo
sudo zypper --gpg-auto-import-keys refresh
```

## 2. 安装Lomorage

和Rocky Linux类似，openSUSE Leap的默认源里没有可用版本的`vips`，所以这里
也需要用从源码编译的`lomo-vips`，和Debian/Ubuntu/Rocky的情况一样。

```bash
sudo zypper install lomo-vips lomo-backend
```

确保当前用户sudo不用密码, 如果不行，可以通过下面的命令添加:

```bash
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

### 3. 按需修改运行参数

用户可以在"/opt/lomorage/etc/environment"设置环境变量来修改某些运行参数。用户可以根据自己实际情况加以调整。

#### 3.1 修改磁盘mount目录

如果USB磁盘没有加载到"/media"路径下，您需要指定加载目录。

要指定加载目录"/media/pi", 请添加环境变量`LOMOD_MOUNT_DIR=/media/pi`在`/opt/lomorage/etc/environment`，比如

```
echo "LOMOD_MOUNT_DIR=/media/pi" | tee -a /opt/lomorage/etc/environment
```

**请确保您的用户有上面设置的"mount-dir"的读写权限, 另外改参数必须是mount的父目录，比如mount到"/media/pi/disk0"下面，就必须指定为"/media/pi"**

#### 3.2 HTTP 监听端口

Lomod缺省监听端口是8000，如果需要自定义，清使用环境变量`LOMOD_PORT_HTTP`，比如

```
echo "LOMOD_PORT_HTTP=8888" | tee -a /opt/lomorage/etc/environment
```

另外的方案是`cp /lib/systemd/system/lomod.service /etc/systemd/system/lomod.service`，然后编辑"/etc/systemd/system/lomod.service"，修改"ExecStart"指定要用的参数(运行`/opt/lomorage/bin/lomod -h`查看可用的参数)，然后运行`sudo systemctl daemon-reload`之后，就会使用"/etc/systemd/system/lomod.service"的配置了。 "/lib/systemd/system/lomod.service"在升级时会被覆盖。

## 4. 运行

重启"Lomorage照片助手"程序:

```bash
sudo systemctl restart lomod
```
