+++
title = "简单快速地迁移数据和扩展存储空间"
tags = ["WD", "MyCloud", "Redundancy"]
categories = ["BLOG"]
date = "2023-03-02T13:43:40"
banner = "/img/blog/migrate_from_pi_win/migrate_pi_win.jpg"
+++

  **简单快速地迁移数据和扩展存储空间**

  最近有个用户因为原先的存储盘已经满了，想把数据直接从原先的PI服务器迁移到Windows服务器上，并且扩大存储盘，让我们来看看最快的数据迁移扩展方法，本文也可以用来指导数据恢复。本文以Windows为例，其它平台操作也类似。
  
<!--more--> 

 <div align="center">
<p class="screenshoot">
  <img width="50%" src="/img/blog/migrate_from_pi_win/migrate_pi_win.jpg">
</p>
</div> 

本文目录
=================
- [本文目录](#本文目录)
- [第1步：安装Windows Lomorage 照片助手](#第1步安装windows-lomorage-照片助手)
- [第2步：复制数据](#第2步复制数据)
- [第3步： 更改assets.db 里的user 表里的home\_dir](#第3步-更改assetsdb-里的user-表里的home_dir)
  - [3.1 下载 辅助工具](#31-下载-辅助工具)
  - [3.2 停止照片助手，把改好的assets.db 复制到默认的安装位置：](#32-停止照片助手把改好的assetsdb-复制到默认的安装位置)
  - [3.3 重启照片助手完成数据迁移，再也不怕数据满盘了！](#33-重启照片助手完成数据迁移再也不怕数据满盘了)


# 第1步：安装Windows Lomorage 照片助手

请直接去 [lomorage](https://lomorage.com)官网下载windows版本的照片助手并且按照默认设置安装。

# 第2步：复制数据

原先的存储盘已经满了，所以用户A选择了一个新**10T**的大硬盘，然后把数据从老的硬盘拷贝到了新的硬盘里。
新硬盘的数据目录是：

**d:\imagebk**

确保 **d:\imagebk** 下是原先的用户名目录，像如下这样：

```
d:\imagebk
|-- test
|-- user_name
|-- user_name2
|-- assets.db
```

**提示：assets.db 就是数据文件，这个非常重要**


# 第3步： 更改assets.db 里的user 表里的home_dir

## 3.1 下载 辅助工具

请去 https://sqlitebrowser.org/ 网站下载，然后用sqlitebrowser 工具打开 assets.db, 如下图一样更改**home_dir**


 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/migrate_from_pi_win/assets_db_zh.png">
</p>
</div> 

## 3.2 停止照片助手，把改好的assets.db 复制到默认的安装位置：

**> c:\Users\\%username%\AppData\Local\lomoware\var\assets.db**

## 3.3 重启照片助手完成数据迁移，再也不怕数据满盘了！



**支持**: support@lomorage.com or lomorage@gmail.com.

或者加 **微信：lomoware**，加入微信群，和开发者互动。

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/lomorage_wechat_qr.jpg
">
</p>
</div> 

新的开发版已经自动支持一键迁移恢复数据, 敬请期待：

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/migrate_from_pi_win/one_click_recover.png">
</p>
</div> 