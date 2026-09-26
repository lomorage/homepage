---
title: Rocky Linux 9
weight: 8
---

# 在Rocky Linux 9上安装"Lomorage照片助手"

**当前我们只支持x86/AMD64 Rocky Linux 9（以及包格式相同的RHEL/AlmaLinux 9）。**

## 1. 启用 EPEL 和 RPM Fusion

`perl-Image-ExifTool`需要[EPEL](https://docs.fedoraproject.org/en-US/epel/)，`ffmpeg`（视频处理需要）需要
[RPM Fusion](https://rpmfusion.org/)，两者都不在默认源中：

```bash
sudo dnf install epel-release -y
sudo dnf install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm -y
```

## 2. 安装lomoware源

```bash
sudo tee /etc/yum.repos.d/lomoware.repo > /dev/null <<'EOF'
[lomoware-rocky9]
name=Lomoware Rocky Linux 9 Repository
baseurl=https://lomoware.lomorage.com/rpm/rocky9
enabled=1
gpgcheck=1
gpgkey=https://lomoware.lomorage.com/rpm/rocky9/repodata/repomd.xml.key
EOF
```

## 3. 安装Lomorage

和Fedora不同，Rocky 9的默认源里完全没有`vips`，所以这里需要用从源码编译的
`lomo-vips`，和Debian/Ubuntu的情况一样。

```bash
sudo dnf install lomo-vips lomo-backend -y
```

确保当前用户sudo不用密码, 如果不行，可以通过下面的命令添加:

```bash
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

### 4. 按需修改运行参数

用户可以在"/opt/lomorage/etc/environment"设置环境变量来修改某些运行参数。用户可以根据自己实际情况加以调整。

#### 4.1 修改磁盘mount目录

如果USB磁盘没有加载到"/media"路径下，您需要指定加载目录。

要指定加载目录"/media/pi", 请添加环境变量`LOMOD_MOUNT_DIR=/media/pi`在`/opt/lomorage/etc/environment`，比如

```
echo "LOMOD_MOUNT_DIR=/media/pi" | tee -a /opt/lomorage/etc/environment
```

**请确保您的用户有上面设置的"mount-dir"的读写权限, 另外改参数必须是mount的父目录，比如mount到"/media/pi/disk0"下面，就必须指定为"/media/pi"**

#### 4.2 HTTP 监听端口

Lomod缺省监听端口是8000，如果需要自定义，清使用环境变量`LOMOD_PORT_HTTP`，比如

```
echo "LOMOD_PORT_HTTP=8888" | tee -a /opt/lomorage/etc/environment
```

另外的方案是`cp /lib/systemd/system/lomod.service /etc/systemd/system/lomod.service`，然后编辑"/etc/systemd/system/lomod.service"，修改"ExecStart"指定要用的参数(运行`/opt/lomorage/bin/lomod -h`查看可用的参数)，然后运行`sudo systemctl daemon-reload`之后，就会使用"/etc/systemd/system/lomod.service"的配置了。 "/lib/systemd/system/lomod.service"在升级时会被覆盖。

## 5. 运行

重启"Lomorage照片助手"程序:

```bash
sudo systemctl restart lomod
```
