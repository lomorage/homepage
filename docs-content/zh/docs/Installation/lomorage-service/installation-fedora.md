---
title: Fedora
weight: 7
---

# 在Fedora上安装"Lomorage照片助手"

**当前我们只支持x86/AMD64 Fedora（当前最新稳定版）。**

## 1. 启用 RPM Fusion

`ffmpeg`（视频处理需要）由于授权原因不在Fedora的默认源中，需要先启用
[RPM Fusion](https://rpmfusion.org/)：

```bash
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
```

## 2. 安装lomoware源

```bash
sudo tee /etc/yum.repos.d/lomoware.repo > /dev/null <<'EOF'
[lomoware-fedora]
name=Lomoware Fedora Repository
baseurl=https://lomoware.lomorage.com/rpm/fedora
enabled=1
gpgcheck=1
gpgkey=https://lomoware.lomorage.com/rpm/fedora/repodata/repomd.xml.key
EOF
```

## 3. 安装Lomorage

和Debian/Ubuntu不同，Fedora下`lomo-vips`不是单独的包 -- Fedora自带的源里
直接有`vips`，安装时会自动拉取。

```bash
sudo dnf install lomo-backend -y
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
