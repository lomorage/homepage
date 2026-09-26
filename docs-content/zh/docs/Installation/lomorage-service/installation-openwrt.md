---
title: Openwrt
weight: 6
---

# Openwrt安装

Lomorage的opkg包安装依赖Entware软件仓库中的其他包(比如ffmpeg exif-tools)。

当前在Beta测试中，如果您碰到什么问题请联系我们。

## 快速开始

### 1. 安装Entware

请参考[这里](https://github.com/Entware/Entware/wiki/Alternative-install-vs-standard)的步骤来安装Entware到目标机上。

您可以使用`cat /proc/cpuinfo`命令来检查系统架构:

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

如果是MIPS，可以使用 `lscpu`来查看字节序，mips是big-endian架构,. mipsel是little-endian架构。

```
root@OpenWrt:/mnt/sda1# lscpu | grep "Byte Order"
Byte Order:          Big Endian
```

然后您可以使用`uname -a `查看Linux版本号:

```
root@OpenWrt:/mnt/sda1# uname -a
Linux OpenWrt 4.14.221 #0 Mon Feb 15 15:22:37 2021 mips GNU/Linux
```

通常您需要加载USB驱动器，并将包安装到上面，参考:

1. https://openwrt.org/docs/guide-user/storage/usb-drives-quickstart#procedure
2. https://www.jianshu.com/p/4061eeaccd13

**确保修改了"/etc/profile"，添加`/opt/bin/go/bin:/opt/bin`到`PATH`，添加`/opt/lib/`到`LD_LIBRARY_PATH`**

Entware安装好了后，可以从Entware安装下面的依赖和工具:

```
root@OpenWrt:~# opkg install coreutils-stat perl-image-exiftool ffmpeg ffprobe lsblk
```

### 2. 安装Lomorage

现在支持的系统平台如下:

```
aarch64-3.10    # arm64, linux kernel ver >= 3.10
armv7-3.2       # armv7, linux kernel ver >=3.2
mips-3.4        # mips big-endian, linux kernel ver >=3.2
mipsel-3.4      # mips little-endian, linux kernel ver >=3.2
```

添加`src/gz lomorage https://lomostaging.lomorage.com/opkg/[architecture]`到`/opt/etc/opkg.conf`，将`[architecture]`替换为你的系统架构，比如如果是mips big-endian, linux kernel ver >=3.2, 使用`src/gz lomorage https://lomostaging.lomorage.com/opkg/mips-3.4`。必须将其放置到 **"entware" 条目的下面**，因为entware中有些需要的包没有打开需要的编译选项，需要使用Lomorage源中的包。

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

然后您可以安装"lomo-backend"，所有的依赖应该都能自动安装:

```
root@OpenWrt:/mnt/sda1/# opkg update --no-check-certificate
root@OpenWrt:/mnt/sda1/# opkg install lomo-backend --no-check-certificate
```

"lomod"安装完成后会自动启动，默认的加载目录是"/mnt"，端口号"8000"，你也可以使用下面的命令控制:

```
root@OpenWrt:/mnt/sda1# /opt/etc/init.d/lomod
Usage: /opt/etc/init.d/lomod {start|stop|restart}
```

需要注意的是对于"arm"架构，会有两个版本: "hf" and "nohf", "hf"是hard float的缩写，可以通过`grep "fpu" /proc/cpuinfo`来查看CPU是否支持hard float，如果命令输出显示`fpu     : yes`那就是支持. **如果不支持hard float，您需要安装nohf版本的包:**

```
root@OpenWrt:/mnt/sda1/# opkg install lomo-backend_nohf --no-check-certificate
```

接下来您可以使用cron job来每天4:00 am自动更新lomo-backend:

```
root@OpenWrt:~# crontab -e
```

添加下面的内容:

```
0 4 * * * opkg update --no-check-certificate && opkg install lomo-backend --no-check-certificate
```
