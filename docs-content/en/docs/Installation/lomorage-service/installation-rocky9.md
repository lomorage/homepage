---
title: Rocky Linux 9
weight: 8
---

# Install "Lomorage Photo Assistant" on Rocky Linux 9

**Currently we only support x86/AMD64 Rocky Linux 9 (and RHEL/AlmaLinux 9, which share the same package format).**

## 1. Enable EPEL and RPM Fusion

`perl-Image-ExifTool` needs [EPEL](https://docs.fedoraproject.org/en-US/epel/), and `ffmpeg` (needed for video processing) needs [RPM Fusion](https://rpmfusion.org/) -- neither is in the base repos:

```bash
sudo dnf install epel-release -y
sudo dnf install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm -y
```

## 2. Add lomoware source

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

## 3. Install Lomorage

Unlike Fedora, Rocky 9's base repos don't have `vips` at all, so `lomo-vips`
(built from source) is required here, same as Debian/Ubuntu.

```bash
sudo dnf install lomo-vips lomo-backend -y
```

Make sure the user can sudo without password, if not, execute the following command to add it:

```bash
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
```

### 4. Configuration parameter customization

User can use environment variable in "/opt/lomorage/etc/environment" to control configuration parameter as below. You can change based on your own setup.

#### 4.1 Change mount directory

You may need to specify the mount directory if the USB drive is not mounted in "/media" directory.

To specify the mount directory to be "/media/pi", add environment variable `LOMOD_MOUNT_DIR=/media/pi` in `/opt/lomorage/etc/environment`, such as

```
echo "LOMOD_MOUNT_DIR=/media/pi" | tee -a /opt/lomorage/etc/environment
```

**this parameter should be the directory mount, not the sub-directory**

**Make sure the user has the r/w permission for above mount directory, this parameter should be the parent directory mounted, for example if it's mounted as "/media/pi/disk0", then you should use "/media/pi/".**

#### 4.2 HTTP Listen Port

Lomod listens on port 8000 by default. If it is conflict and you want to specify own listen port, you can add environment variable `LOMOD_PORT_HTTP` in `/opt/lomorage/etc/environment`. For example,

```
echo "LOMOD_PORT_HTTP=8888" | tee -a /opt/lomorage/etc/environment
```

Another option is `cp /lib/systemd/system/lomod.service /etc/systemd/system/lomod.service` and then edit "/etc/systemd/system/lomod.service" and change "ExecStart" directly to specify the parameters used (run `/opt/lomorage/bin/lomod -h` to check the parameters), and run `sudo systemctl daemon-reload`, then it will use "/etc/systemd/system/lomod.service" instead. "/lib/systemd/system/lomod.service" is expected to be overwritten when upgrade.

## 5. Run

Restart "Lomorage Photo Assistant":

```bash
sudo systemctl restart lomod
```
