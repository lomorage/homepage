---
title: Unraid
weight: 6
---

# 在Unraid App Store里面选择并安装Lomorage

1. 输入关键字lomorage，点击搜索

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid1.png">
</p>

当您发现lomorage应用以后，您可以点击`info`图标，从而了解更多有关lomorage在unraid论坛里面的支持

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid2.png">
</p>

2. 点击安装，当下图出现的时候，说明安装已经成功

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid3.png">
</p>

# Unraid 模版修改
如果您对缺省的模版需要修改，请参考以下说明：

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/unraid4.png">
</p>

- Network: 缺省值是`host`模式，这主要是因为手机客户端需要试用MDNS来自动发现"Lomorage照片助手"，如果您愿意手动配置手机客户端，可以将此处设置为bridge模式
- ExtraParams: 缺省值是`99:100`. 这个参数需要和下面的`User` 配置一起使用。这个值主要是为了保证上传的图片和视频可以有正确的Linux用户名和组名，这样的话用户就可以利用unraid的共享服务，从电脑端远程访问图片和视频.其中，99 是`nobody`用户在linux下面的ID, 100 是`nobody`组在linux下面的ID. 用户可以根据自己需要定制这些值.
- PostArgs: 缺省值是`8000`, 是 lomorage 后端的监听端口.
- Config
  * MediaDir: 这个目录是上传的媒体存储目录，缺省值是`/mnt/user/`
  * AppDir: 这个目录是lomorage后端配置文件，数据库文件和日志文件的存储目录，缺省值是`/mnt/user/appdata`
  * User: 这个文件是将实际的用户id信息传入到后端，从而保证后台可以生成正确的用户名.

## Nginx Proxy Manager 集成
Nginx Proxy Manager 是一个流行的免费反向代理服务器，可以用来把内网的服务映射到公网internet上面。unraid社区已经有了官方支持的app，用户可以自行安装.

1. 登陆之后，点击 `Add Proxy Host`, 然后设置自己的域名和转发ip，转发端口是上面设置的监听端口

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/npm1.png">
</p>

2. 点击 `SSL`，配置证书域名

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/npm2.png">
</p>

3. 点击`Save`, 新添加的proxy host会显示在列表中

<p align="center">
  <img style="max-width:100%; object-fit: contain;"  src="/img/installation/npm3.png">
</p>
