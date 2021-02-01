You can either use the docker installation, or install using APT

# Docker installation

Please refer to [lomo-docker](https://github.com/lomorage/lomo-docker) for installation with docker image. You can either use the arm image "lomorage/raspberrypi-lomorage:latest" or amd64 image "lomorage/amd64-lomorage:latest" based on the host architecture.

# APT installation

**Currently we only support x86/AMD64 Ubuntu 18.04.5 LTS (Bionic Beaver) and Ubuntu 20.04.1 LTS (Focal Fossa).**

## 1. Add lomoware source

```
sudo apt install -y ca-certificates python-certifi python3-certifi
sudo update-ca-certificates --fresh
wget -qO - https://raw.githubusercontent.com/lomoware/lomoware.github.io/master/debian/gpg.key | sudo apt-key add -
```

If you are using Bionic:

```
echo "deb https://lomoware.github.io/debian/bionic bionic main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

If you are using Focal:

```
echo "deb https://lomoware.github.io/debian/focal focal main" | sudo tee /etc/apt/sources.list.d/lomoware.list
```

then run:

```
sudo apt update
```

## 2. Install Lomorage

You need at least lomo-vips, lomo-base-lite and lomo-backend installed.

- lomo-backend: mandatory, Lomorage service backend

- lomo-web: optional, Lomorage web application

- lomo-base-lite: optional, hard drive mount tool, rsync, jq etc

- lomo-vips: mandatory, lomorage vips clone. (A fast image processing library with low memory needs), used by lomo-backend

```
sudo apt install lomo-base lomo-vips lomo-backend lomo-web -y
```

## 3. Change mount directory

You may need to specify the mount directory if the USB drive is not mounted in "/media" directory. 

To change the default mount directory, modify `ExecStart` in "/lib/systemd/system/lomod.service", and add parameter "--mount-dir" as below

```
ExecStart=/opt/lomorage/bin/lomod -b /opt/lomorage/var --mount-dir your-mount-dir  --max-upload 1 --max-fetch-preview 3
```

**Make sure the user has the r/w permission for the "mount-dir" set above**

## 4. Run

Restart Lomorage service:

```
# restart lomo-backend
sudo systemctl restart lomod

# restart lomo-web
sudo systemctl restart lomow

# restart lomo-frame
sudo service supervisor restart
```