可以有两种安装方式:

  - Docker安装

  - 构建自己的镜像

# Docker安装

请参考[lomo-docker](https://github.com/lomorage/lomo-docker)安装Docker镜像。请使用arm的镜像"lomorage/raspberrypi-lomorage:latest"。

# 构建自己的镜像

下面的步骤应该对于所有Armbain官方支持的SBC都适用，但如果您发现有问题，请联系我们。

这里有已经编译好的[Orange Pi Zero](http://www.orangepi.org/orangepizero/)的[镜像](https://github.com/lomorage/build/releases/download/2021_02_01.23_18_29.0.829c7a4/Armbian_21.02.0-trunk_Orangepizero_buster_current_5.10.11_minimal.img.xz)。

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