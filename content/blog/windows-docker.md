+++
title = "Run Lomoage Docker in Windows 10"
tags = ["Docker", "Container", "Lomorage"]
categories = ["Docker"]
date = "2020-11-16T22:43:40"
banner = "img/blog/win-docker/win-docker-banner.png"
+++

 Though Lomorage already provide Windows Native MSI package, But if you like to run Docker image in Windows, please follow below steps to do so. Esp. on Windows Server, Docker can leverage the Windows HYPER-v technology，and let the Lomorage running faster. If you do not know what is Docker, you also can download the native Lomorage installer for Windows, [Download Lomorage Windows Installer](https://lomorage.com/zh/installation-win/)。

<!--more--> 

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/win-docker/docker.png">
</p>
</div>



# 1. Dwownload Docker

Just go to Docker official site to downlad the Docker Windows installer, and double click to run the setup with the default settings.
Please restart the Windows machine after finish the docker installing.


# 2. PUll Lomorage Image

Use one kind of terminal like: Windows Terminal or Git-bash or Windows Power Shell or CMD：

> docker pull lomorage/raspberrypi-lomorage:latest

# 3. Run Docker image

Please download this script https://raw.githubusercontent.com/lomorage/lomo-docker/master/run.sh

And then do some change

**from** 

 > docker run --user=*****

**to**

 > docker run --user=root:root

Then in terminal run below command:

> $ ./run.sh -d -m h:/docker-lomorage -b h:/var/lomorage -h 192.168.0.63

**Please note** h:/docker-lomorage is your Windows directoy，so does for h:/var/lomorage。 192.168.0.63 is your Windows IP.

# 4. Check the docker is successful

- Open Lomorage APP in your phone，input IP address and port, on this case, IP is: 192.168.0.53, Port is: 8000

- Open browser， input： http://192.168.0.63:8001, should has below image:

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/win-docker/web-client.png">
</p>
</div>

Also, you can changed the **run.sh** script if you familiar with Docker to meet your requirements.

Enjoy and happy Lomorage!