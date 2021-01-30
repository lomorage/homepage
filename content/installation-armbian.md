You have two options to install.

# Docker installation

- Follow the [instruction](https://docs.docker.com/engine/install/debian/) to install docker

- Pull from docker hub.

```
sudo docker pull lomorage/raspberrypi-lomorage:latest
```

- Run

Download [run.sh](https://raw.githubusercontent.com/lomorage/lomo-docker/master/run.sh).

You can specify the media home directory and lomo directory, otherwise it will use the default, you MUST specify the host, subnet, gateway, network-interface, vlan-address.
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

You can add the command in "/etc/rc.local" before "exit 0" to make it run automatically after system boot.

# Build your own image

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