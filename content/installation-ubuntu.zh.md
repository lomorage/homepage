您可以使用docker或者APT的方式安装。

# Docker安装

请参考[lomo-docker](https://github.com/lomorage/lomo-docker)安装Docker镜像。您可以根据你的CPU架构选择使用arm的镜像"lomorage/raspberrypi-lomorage:latest" ，或者amd64的镜像"lomorage/amd64-lomorage:latest"。

# APT安装

**当前我们只支持x86/AMD64 Ubuntu 18.04.5 LTS (Bionic Beaver)和Ubuntu 20.04.1 LTS (Focal Fossa)。**

## 1. 安装lomoware源

```
sudo apt install -y ca-certificates python-certifi python3-certifi
sudo update-ca-certificates --fresh
wget -qO - https://raw.githubusercontent.com/lomoware/lomoware.github.io/master/debian/gpg.key | sudo apt-key add -
```

如果您使用Bionic:

```
echo "deb https://lomoware.github.io/debian/bionic bionic main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

如果您使用focal:

```
echo "deb https://lomoware.github.io/debian/focal focal main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

然后运行:

```
sudo apt update
```

## 2. 安装Lomorage

您至少需要安装lomo-vips,lomo-base-lite和lomo-backend。

- lomo-backend: 必须, Lomorage服务程序

- lomo-web: 可选, Lomorage网页程序

- lomo-base: 可选, 系统工具，包括网络配置，开关控制, 磁盘加载, 蓝牙控制台

- lomo-vips: 必须, lomo-backend使用的图像处理库

```
sudo apt install lomo-base lomo-vips lomo-backend lomo-web -y
```

## 3. 更加需要修改mount目录

如果您不是使用步骤4的usbmount来自动加载磁盘（没有加载到"/media"路径下的子目录），您需要添加Lomorage服务程序运行参数来指定加载目录。

如果要修改默认的加载路径，修改文件"/lib/systemd/system/lomod.service"中的`ExecStart`，并添加"--mount-dir"参数:

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir your-mount-dir  --max-upload 1 --max-fetch-preview 3
```

**请确保您的用户有上面设置的"mount-dir"的读写权限**

## 4. 运行

重启Lomorage服务程序:

```
# 重启lomo-backend
sudo systemctl restart lomod

# 重启lomo-web
sudo systemctl restart lomow

# 重启lomo-frame
sudo service supervisor restart
```