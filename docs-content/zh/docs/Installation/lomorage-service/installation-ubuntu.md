---
title: Ubuntu
weight: 3
---

您可以使用docker或者APT的方式安装。

# Docker安装

请参考[lomo-docker](https://github.com/lomorage/lomo-docker)安装Docker镜像。您可以根据你的CPU架构选择使用arm的镜像"lomorage/raspberrypi-lomorage:latest" ，或者amd64的镜像"lomorage/amd64-lomorage:latest"。

# APT安装

**当前我们只支持x86/AMD64 Ubuntu 18.04.5 LTS (Bionic Beaver)、Ubuntu 20.04.1 LTS (Focal Fossa)、Ubuntu 22.04 LTS (Jammy Jellyfish)和Ubuntu 24.04 LTS (Noble Numbat)。**

## 1. 安装lomoware源

```bash
sudo apt install -y ca-certificates python-certifi python3-certifi
sudo update-ca-certificates --fresh
curl -fsSL https://lomoware.lomorage.com/debian/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/lomorage-apt-key.gpg > /dev/null
```

如果您使用Bionic:

```bash
echo "deb [arch=amd64] https://lomoware.lomorage.com/debian/bionic bionic main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用focal:

```bash
echo "deb [arch=amd64] https://lomoware.lomorage.com/debian/focal focal main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用jammy:

```bash
echo "deb [arch=amd64] https://lomoware.lomorage.com/debian/jammy jammy main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用noble:

```bash
echo "deb [arch=amd64] https://lomoware.lomorage.com/debian/noble noble main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

然后运行:

```bash
sudo apt update
```

## 2. 安装Lomorage

您至少需要安装lomo-vips,lomo-base-lite和lomo-backend。

- lomo-backend: 必须, "Lomorage照片助手"程序

- lomo-base-lite: 可选, 硬盘自动加载和休眠

- lomo-vips: 必须, lomo-backend使用的图像处理库

```bash
sudo apt install lomo-base-lite lomo-vips lomo-backend -y
```

确保当前用户sudo不用密码, 如果不行，可以通过下面的命令添加:

```bash
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

### 3. 按需修改运行参数

用户可以在"/opt/lomorage/etc/environment"设置环境变量来修改某些运行参数。用户可以根据自己实际情况加以调整。

#### 3.1 修改磁盘mount目录

如果您不是使用步骤4的usbmount来自动加载磁盘（没有加载到"/media"路径下的子目录），您需要添加"Lomorage照片助手"程序运行参数来指定加载目录。

比如如果您使用PCManFM，那么加载的路径会是"/media/pi"。 要指定加载目录"/media/pi", 请添加环境变量`LOMOD_MOUNT_DIR=/media/pi`在`/opt/lomorage/etc/environment`，比如

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
# 重启lomo-backend
sudo systemctl restart lomod

# 重启lomo-frame
sudo service supervisor restart
```
