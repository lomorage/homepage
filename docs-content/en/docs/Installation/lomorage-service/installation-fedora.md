---
title: Fedora
weight: 7
---

# Install "Lomorage Photo Assistant" on Fedora

**Currently we only support x86/AMD64 Fedora (current stable release).**

## 1. Enable RPM Fusion

`ffmpeg` (needed for video processing) isn't in Fedora's base repos due to
licensing, so [RPM Fusion](https://rpmfusion.org/) needs to be enabled first:

```bash
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
```

## 2. Add lomoware source

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

## 3. Install Lomorage

Unlike Debian/Ubuntu, `lomo-vips` isn't a separate package on Fedora --
`vips` is available directly from Fedora's own repos and pulled in
automatically.

```bash
sudo dnf install lomo-backend -y
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
