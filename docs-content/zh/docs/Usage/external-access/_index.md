---
weight: 13
title: "外网访问"
---

# 外网访问设置

外网访问主要有两种方式
1. 通过第三方隧道连接服务
2. 家用路由器打开端口映射，然后配置HTTP反向代理服务

## 使用第三方隧道连接服务(选项1)
外网访问依赖于隧道连接服务来实现内网穿透，现有一些服务提供商提供免费的服务，大多数隧道服务都需要下载客户端，运行在您的设备上，同公网的隧道服务器建立连接，并分配子域名，当通过子域名进行访问时，隧道服务就会将请求转发到您的应用程序。

您可以使用[ngrok](https://ngrok.com)，ngrok是免费的隧道服务，需要注册，使用自定义子域名需要付费，但更加稳定，并没有额外的依赖。本文后续章节主要介绍这个软件，您也可以选择其他的第三方服务

### 1. 注册

[注册](https://dashboard.ngrok.com/signup)ngrok，完成后，会显示"设置和安装"页面.

### 2. 下载

ngrok只有一个二进制文件，您可以下载特定平台的版本。

如果您使用树莓派，您需要在"设置和安装"页面中拷贝Linux(ARM)版本的链接，当前是"https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip", 您可以通过"wget"来下载。

```bash
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
```

### 3. 安装

解压缩得到二进制可执行文件。在Windows或macOS下，您可以双击解压，如果您使用树莓派，可以使用unzip命令

```bash
unzip ngrok-stable-linux-arm.zip
```

### 4. 连接您的账号

在"设置和安装"页面的第三步会显示"authtoken"，您需要在**命令行窗口**中运行如下命令将"authtoken"添加到配置文件。

```bash
./ngrok authtoken [your-authtoken-show-in-step-3]
```

### 5. 运行ngrok

"Lomorage照片助手"默认运行在8000端口，ngrok的免费账号不能自定义子域名，ngrok运行成功后，会自动绑定一个随机子域名，这个子域名在下次ngrok重新启动时会变化。

```bash
./ngrok http 8000
```

<script id="asciicast-265359" src="https://asciinema.org/a/265359.js" async></script>

### 6. 在Lomorage手机应用中配置隧道服务

打开Lomorage手机应用，在配置选项页里找到"外网服务"，设置服务器地址为ngrok输出的url，比如类似"2e30eea5.ngrok.io"，端口号是"443"。

## Nginx https代理 (方案2)

另外的方案：如果您自己有域名，可以直接在路由器上打开端口映射并且配置https代理访问"Lomorage照片助手"。如果您对nignx配置比较熟悉，可以参考关于nginx的配置；否则建议使用比较流行的Nginx Proxy Manager开源软件进行配置

{{< hint info >}}
如果您使用Lomorage的树莓派镜像, 登陆的用户名是"pi"，密码是"raspberry";
如果您使用Lomorage的Armbian镜像, 登陆的用户名是"lomoware"，密码是"lomorage";
{{< /hint >}}

### Nginx Proxy Manager 集成
Nginx Proxy Manager 是一个流行的免费反向代理服务器，可以用来把内网的服务映射到公网internet上面。用户可以参考官方文档 https://nginxproxymanager.com 自行安装.

1. 登陆之后，点击 `Add Proxy Host`, 然后设置自己的域名和转发ip，转发端口是上面设置的监听端口

<p align="center">
  <img width="50%" src="/img/installation/npm1.png">
</p>

2. 点击 `SSL`，配置证书域名

<p align="center">
  <img width="50%" src="/img/installation/npm2.png">
</p>

3. 点击`Save`, 新添加的proxy host会显示在列表中

<p align="center">
  <img width="50%" src="/img/installation/npm3.png">
</p>

接下来就可以尝试访问

### Nginx高级配置

下面以Linux平台为例子，certbox和nginx都是跨平台软件，其他平台安装配置类似。

## 1. 安装certbot和nginx

```
$ sudo apt-get install certbot python-certbot-nginx -y
```

## 2. 生成证书

首先确保域名配置正确，然后在路由器上打开端口映射，将外网TCP80端口和443端口分别映射到安装nginx的设备80端口和443端口上。（下面配置以bob.lomorage.com 为例，请替换为自己的域名。）

```
$ sudo certbot --nginx -d bob.lomorage.com
```

这一步会输出证书目录

```
$ sudo certbot --nginx -d bob.lomorage.com
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Requesting a certificate for bob.lomorage.com

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/bob.lomorage.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/bob.lomorage.com/privkey.pem
This certificate expires on 2021-11-14.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.
```

## 3. 配置nginx

sudo创建文件“/etc/nginx/conf.d/lomorage.conf”，并填入如下内容（下面配置以bob.lomorage.com 为例，请替换为自己的域名。）:

```
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name bob.lomorage.com;

    ssl on;
    ssl_certificate /etc/letsencrypt/live/bob.lomorage.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/bob.lomorage.com/privkey.pem;

    location / {
        client_max_body_size 0;
        proxy_pass http://localhost:8000;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
}
```

如果Lomorage和nginx运行在不同的设备上，可以将localhost改成"Lomorage照片助手"的ip地址。

配置完成后，重新加载配置并启用nginx服务:

```
sudo systemctl restart nginx
sudo systemctl enable nginx
```

最后可以在电脑或者手机浏览器下访问https://bob.lomorage.com/system 验证（请替换为自己的域名）是否能通过https访问"Lomorage照片助手"。
