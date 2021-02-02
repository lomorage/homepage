You have two options to install:

  - Docker installation

  - Build your own image

# Docker installation

Please refer to [lomo-docker](https://github.com/lomorage/lomo-docker) for installation with docker image. You should use the arm image "lomorage/raspberrypi-lomorage:latest".

# Build your own image

It should support all the SBC supported by official Armbain, but if you find it doesn't work, feel free to reach us.

There is a [prebuild image](https://github.com/lomorage/build/releases/download/2021_02_01.23_18_29.0.829c7a4/Armbian_21.02.0-trunk_Orangepizero_buster_current_5.10.11_minimal.img.xz) for [Orange Pi Zero](http://www.orangepi.org/orangepizero/)b.

## 1. Prepare build env

If you are using Ubuntu Focal 20.04.x amd64, you can skip this step.

- Download and install [Vagrant](https://www.vagrantup.com/downloads.html).

- Install a plug-in that will enable us to resize the primary storage device:

```
vagrant plugin install vagrant-disksize
```

- Install git and clone the Armbian repo:

```
# Clone the project.  
git clone --depth 1 https://github.com/lomorage/build

# Make the Vagrant box available. This might take a while but only needs to be done once.  
vagrant box add ubuntu/focal64

# If the box gets updated by the folks at HashiCorp, we'll want to update our copy too.  
# This only needs done once and a while.  
vagrant box update
```

## 2. Build the image

- First bring the box up:

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

- Change to board parameter in "userpatches/config-default.conf", the default is `BOARD="orangepizero"`, if you don't know the board name, you can just use `BOARD=""` and choose the board when compiling.

- build image:

```
# Let's get building!  
cd armbian  
sudo ./compile.sh
```

After build successfully, the image will be generated in `output/images`.