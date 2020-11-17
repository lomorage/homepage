+++
title = "在Windows 10 上安装Lomorage容器镜像"
tags = ["Docker", "容器", "Lomorage"]
categories = ["容器"]
date = "2020-11-16T22:43:40"
banner = "img/blog/win-docker/win-docker-banner.png"
+++

虽然Lomorage已经提供了Windows原生安装包，但对于喜欢使用Docker的人来说，用Docker来配置Lomorage服务器，也是一个非常好的选择，尤其在Windows Server上可以极大的发挥HYPER-v技术，让Lomorage的服务器健步如飞。本篇适合有Docker使用经验的人员，如果您不知道Docker是啥，请[直接下载Lomorage原生安装包](https://lomorage.com/zh/installation-win/)。

<!--more--> 

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/win-docker/docker.png">
</p>
</div>



# 1. 下载Docker

这个不必多说，直接去 Docker 的官网下载Windows 的安装包，双击默认设置安装，根据提示重启机器。


# 2. PUll lomorage的Docker 镜像

使用Windows Terminal 或者 Git-bash，或者Windows 的Power Shell 或者CMD：

> docker pull lomorage/raspberrypi-lomorage:latest

# 3. 运行您的Lomorage 服务器
先下载 https://raw.githubusercontent.com/lomorage/lomo-docker/master/run.sh
这个脚本。

然后把里面的：

 > docker run --user=*****

改成

 > docker run --user=root:root

最后在你熟悉的Terminal里运行：

> $ ./run.sh -d -m h:/docker-lomorage -b h:/var/lomorage -h 192.168.0.63

**请注意** h:/docker-lomorage 是您Windows 机器的盘符，同理 h:/var/lomorage。 192.168.0.63 是您Windows 机器的iP

# 4. 检查是否成功

- 打开手机APP，手工输入 IP 地址，和 端口号， 尝试去创建一个用户。

- 打开browser， 输入： http://192.168.0.63:8001, 应该会打开如下的页面：

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/win-docker/web-client.png">
</p>
</div>