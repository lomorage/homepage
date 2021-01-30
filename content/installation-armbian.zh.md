可以有两种安装方式。

# Docker安装

- 按[这里](https://docs.docker.com/engine/install/debian/)的步骤安装docker[instruction]

- 从docker hub拉Lomorage的image

```
sudo docker pull lomorage/raspberrypi-lomorage:latest
```

- 运行

下载[run.sh](https://raw.githubusercontent.com/lomorage/lomo-docker/master/run.sh)。

您可以指定媒体存储目录和Lomorage运行目录，不指定会使用默认值，您**必须**指定host, subnet, gateway, network-interface, vlan-address参数。

```
run.sh [-m {media-dir} -b {lomo-dir} -d -p {lomod-port} -P {lomow-port} -i {image-name}] -h host -s subnet -g gateway -n network-interface -a vlan-address

Command line options:
    -m  DIR         Absolute path of media directory used for media assets, default to "/media", optional
    -b  DIR         Absolute path of lomo directory used for db and log files, default to "/home/jeromy/lomo", optional
    -h  HOST        IP address or hostname of the host machine, required
    -s  SUBNET      Subnet of the host network(like 192.168.1.0/24), required
    -g  GATEWAY     gateway of the host network(like 192.168.1.1), required
    -n  NETWORK_INF network interface of the host network(like eth0), required
    -a  VLAN_ADDR   vlan address to be used(like 192.168.1.99), required
    -p  LOMOD_PORT  lomo-backend service port exposed on host machine, default to "8000", optional
    -P  LOMOW_PORT  lomo-web service port exposed on host machine, default to "8001", optional
    -i  IMAGE_NAME  docker image name, for example "lomorage/raspberrypi-lomorage:[tag]", default "lomorage/raspberrypi-lomorage:latest", optional
    -d              Debug mode to run in foreground, default to 0, optional

Examples:
    # assuming your hard drive mounted in /media, like /media/usb0, /media/usb0
    ./run.sh -m /media -b /home/pi/lomo -h 192.168.1.232 -s 192.168.1.0/24 -g 192.168.1.1 -n eth0 -a 192.168.1.99
```

您可以将运行命令添加到"/etc/rc.local"中，在"exit 0"之前，这样系统开机的时候就可以自动启动了。

# 构建自己的镜像

## 1. 准备编译环境

如果您使用Ubuntu Focal 20.04.x amd64，可以跳过这一步。

- 下载安装[Vagrant](https://www.vagrantup.com/downloads.html).

- 安装可以调整存储空间大小的插件:

```
vagrant plugin install vagrant-disksize
```

- 安装git并克隆Armbian仓库:

```
# Clone the project.  
git clone --depth 1 https://github.com/lomorage/build

# Make the Vagrant box available. This might take a while but only needs to be done once.  
vagrant box add ubuntu/focal64

# If the box gets updated by the folks at HashiCorp, we'll want to update our copy too.  
# This only needs done once and a while.  
vagrant box update
```

## 2. 构建镜像

- 启动vagrant:

```
# We have to be in the same directory as the Vagrant file, which is in the build/config/templates directory.

cd build/config/templates

#  Note that you can edit the Vagrant  file to specify the number of cpus and amount of memory you want Vagrant to use.

# And now we simply let vagrant create our box and bring it up.

vagrant up

# When the box has been installed we can get access via ssh.
# (No need for passwords, Vagrant installs the keys we'll need.)
vagrant ssh
```

- 修改"userpatches/config-default.conf"中的board参数，默认值是`BOARD="orangepizero"`, 如果不知道board名称，可以使用`BOARD=""`，在后面编译的过程中再选择。

- 构建镜像:

```
# Let's get building!  
cd armbian  
sudo ./compile.sh
```

构建成功后的镜像生成在`output/images`目录。