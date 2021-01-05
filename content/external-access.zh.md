# 外网访问设置

外网访问需要一点技术背景来进行手工设置，我们后续的版本会让这个设置更加简单。

外网访问依赖于隧道连接服务来实现内网穿透，现有一些服务提供商提供免费的服务，大多数隧道服务都需要下载客户端，运行在您的设备上，同公网的隧道服务器建立连接，并分配子域名，当通过子域名进行访问时，隧道服务就会将请求转发到您的应用程序。

您可以使用[localtunnel](https://localtunnel.me)或者[ngrok](https://ngrok.com)，这两个都是免费的隧道服务. localtunnel无需注册，并且支持自定义子域名; ngrok需要注册，使用自定义子域名需要付费，但更加稳定，并没有额外的依赖。

*如果您使用Lomorage的树莓派镜像, 登陆的用户名是"pi"，密码是"raspberry"*

## localtunnel

如果您使用Windows或者macOS，您需要先先安装[nodejs](https://nodejs.org/)，再安装localtunnel。如果您使用Lomorage的树莓派镜像，您可以直接运行`sudo localtunnel_install.sh`来安装localtunnel，您可以跳过下面的步骤1和步骤2。

### 1. 安装nodejs

下载并安装对应平台下的[二进制安装包]((https://nodejs.org/en/download/))。

### 2. 安装localtunnel

打开命令行窗口并输入:

```
npm install -g localtunnel
```

### 3. 运行localtunnel

如果您需要使用子域名"allice" (您可以选择自己的子域名), 打开命令行窗口并输入:

```
lt -s allice -p 8000 --print-requests
```

"-s"指定要使用的子域名, "-p"指定要转发的目的端口, Lomorage服务默认使用"8000", "--print-requests"输出接收到的请求信息。

如果输出结果没有任何错误，并输出类似如下的内容:

```
your url is: https://allice.localtunnel.me
```

您可以在浏览器窗口中打开localtunnel输出的url，如果您能在localtunnel的输出看到刚发出的访问请求日志，隧道服务就已经配置成功了。

```
Sat Aug 31 2019 11:38:00 GMT-0700 (PDT) GET /
```

<script id="asciicast-265358" src="https://asciinema.org/a/265358.js" async></script>

### 4. 在Lomorage手机应用中配置隧道服务

打开Lomorage手机应用，在配置选项页里找到"外网服务"，设置地址为localtunnel输出的url，比如类似"allice.localtunnel.me"。
比如：安卓手机 可以在设置页面进行配置，并测试。如果您的localtunnel是https的，默认端口是**443**，如果是http，端口填**80**.
如图：

<div align="left">
<p class="screenshoot">

  <img width="30%" src="/img/installation/android/external_setting.jpg">
</p>
</div>

## ngrok

### 1. 注册

[注册](https://dashboard.ngrok.com/signup)ngrok，完成后，会显示"设置和安装"页面.

### 2. 下载

ngrok只有一个二进制文件，您可以下载特定平台的版本。

如果您使用树莓派，您需要在"设置和安装"页面中拷贝Linux(ARM)版本的链接，当前是"https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip", 您可以通过"wget"来下载。

```
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
```

### 3. 安装

解压缩得到二进制可执行文件。在Windows或macOS下，您可以双击解压，如果您使用树莓派，可以使用unzip命令

```
unzip ngrok-stable-linux-arm.zip
```

### 4. 连接您的账号

在"设置和安装"页面的第三步会显示"authtoken"，您需要在**命令行窗口**中运行如下命令将"authtoken"添加到配置文件。

```
./ngrok authtoken [your-authtoken-show-in-step-3]
```

### 5. 运行ngrok

Lomorage服务默认运行在8000端口，ngrok的免费账号不能自定义子域名，ngrok运行成功后，会自动绑定一个随机子域名，这个子域名在下次ngrok重新启动时会变化。

```
./ngrok http 8000
```

<script id="asciicast-265359" src="https://asciinema.org/a/265359.js" async></script>

### 6. 在Lomorage手机应用中配置隧道服务

打开Lomorage手机应用，在配置选项页里找到"外网服务"，设置服务器地址为ngrok输出的url，比如类似"2e30eea5.ngrok.io"。