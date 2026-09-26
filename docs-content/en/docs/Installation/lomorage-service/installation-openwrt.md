---
title: Openwrt
weight: 6
---

# Openwrt installation

Lomorage setup using opkg packages with Entware repository (need dependencies in Entware, like ffmpeg exif-tools).

This is currently in Beta, please reach us if you have any problem.

## Quick Start

This is for users who want to setup Lomorage using opkg packets.

### 1. Install Entware

Follow the [instruction](https://github.com/Entware/Entware/wiki/Alternative-install-vs-standard) to install Entware on target machine.

You can use `cat /proc/cpuinfo` to check the architecture:

```
root@OpenWrt:/mnt/sda1# cat /proc/cpuinfo
system type		: Atheros AR9344 rev 2
machine			: Western Digital My Net N750
processor		: 0
cpu model		: MIPS 74Kc V4.12
BogoMIPS		: 278.93
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes, count: 4, address/irw mask: [0x0ffc, 0x0ffc, 0x0ffb, 0x0ffb]
isa			: mips1 mips2 mips32r1 mips32r2
ASEs implemented	: mips16 dsp dsp2
Options implemented	: tlb 4kex 4k_cache prefetch mcheck ejtag llsc dc_aliases perf_cntr_intr_bit nan_legacy nan_2008 perf
shadow register sets	: 1
kscratch registers	: 0
package			: 0
core			: 0
VCED exceptions		: not available
VCEI exceptions		: not available
```

 If it's MIPS, you can use `lscpu` to check the byte order, mips is a big-endian mips architecture,. mipsel is a little-endian mips architecture.

```
root@OpenWrt:/mnt/sda1# lscpu | grep "Byte Order"
Byte Order:          Big Endian
```

And use `uname -a ` to check Linux version:

```
root@OpenWrt:/mnt/sda1# uname -a
Linux OpenWrt 4.14.221 #0 Mon Feb 15 15:22:37 2021 mips GNU/Linux
```

Most likely you need mount USB drive and use that for packages installation, refer to:

1. https://openwrt.org/docs/guide-user/storage/usb-drives-quickstart#procedure
2. https://www.jianshu.com/p/4061eeaccd13

**Make sure you change "/etc/profile" and add `/opt/bin/go/bin:/opt/bin` in `PATH` and `/opt/lib/` in `LD_LIBRARY_PATH`**

Once you have Entware setup ready, install dependencies and tools from Entware repo:

```
root@OpenWrt:~# opkg install coreutils-stat perl-image-exiftool ffmpeg ffprobe lsblk
```

### 2. Install Lomorage

Architectures supported are:

```
aarch64-3.10    # arm64, linux kernel ver >= 3.10
armv7-3.2       # armv7, linux kernel ver >=3.2
mips-3.4        # mips big-endian, linux kernel ver >=3.2
mipsel-3.4      # mips little-endian, linux kernel ver >=3.2
```

Add `src/gz lomorage https://lomostaging.lomorage.com/opkg/[architecture]` in `/opt/etc/opkg.conf`, replace `[architecture]` with those listed above, for example if it's mips big-endian, linux kernel ver >=3.2, use `src/gz lomorage https://lomostaging.lomorage.com/opkg/mips-3.4`. This should **below "entware" entry** because some packages in entware are not compiled with needed flags, and need to be overridden.

```
root@OpenWrt:~# cat /opt/etc/opkg.conf
src/gz entware http://bin.entware.net/mipssf-k3.4
src/gz lomorage https://lomostaging.lomorage.com/opkg/mips-3.4
dest root /
lists_dir ext /opt/var/opkg-lists
arch all 100
arch mips-3x 150
arch mips-3.4 160
```

And then you can install "lomo-backend", all the dependencies should be able to be installed automatically:

```
root@OpenWrt:/mnt/sda1/# opkg update --no-check-certificate
root@OpenWrt:/mnt/sda1/# opkg install lomo-backend --no-check-certificate
```

"lomod" will start automatically after installation, the mount directory is default to "/mnt" and port default to "8000", you can also run:

```
root@OpenWrt:/mnt/sda1# /opt/etc/init.d/lomod
Usage: /opt/etc/init.d/lomod {start|stop|restart}
```

Should be notice that for "arm" architecture, it will has two versions: "hf" and "nohf", "hf" means hard float, you can check whether the CPU supports hard float by `grep "fpu" /proc/cpuinfo` and if it shows `fpu     : yes` then it supports hard float. **And if it doesn't support hard float, you should install the following packages instead:**

```
root@OpenWrt:/mnt/sda1/# opkg install lomo-backend_nohf --no-check-certificate
```

Then you can add cron job to update lomo-backend at 4:00 am everyday:

```
root@OpenWrt:~# crontab -e
```

and add the following item:

```
0 4 * * * opkg update --no-check-certificate && opkg install lomo-backend --no-check-certificate
```
