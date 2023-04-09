+++
title = "把WD MyCloud设置为Lomorage的冗余备份盘"
tags = ["WD", "MyCloud", "Redundancy"]
categories = ["BLOG"]
date = "2023-02-22T13:43:40"
banner = "/img/blog/set_wd_as_backup/set_wd_as_backup.jpg"
+++

  **在Windows上，把WD MyCloud设置为Lomorage的冗余备份盘**
  
<!--more--> 


本文目录
=================
- [本文目录](#本文目录)
- [1. 映射 WD MyCloud 为Windows的盘符](#1-映射-wd-mycloud-为windows的盘符)
- [2. 设置冗余备份](#2-设置冗余备份)
- [3. 测试冗余备份](#3-测试冗余备份)



# 1. 映射 WD MyCloud 为Windows的盘符

具体可以参考WD的官方说明: __[How to mount WD MyCloud on Windows](https://support-en.wd.com/app/answers/detailweb/a_id/25436/h/p2#subject2)__

下面是一个例子，其实就是在局域网内找到WD的盘符，然后映射网络驱动器。

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/set_wd_as_backup/mount_zh.png" style="border:2px solid black;"  />
</p>
</div> 

# 2. 设置冗余备份

 打开Lomorage桌面助手，按下图设置：

 > **确保 **W:\wd-test** 是一个新目录，下面没有其他的内容**

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/set_wd_as_backup/set_redundancy_agent_zh.png">
</p>
</div> 

# 3. 测试冗余备份

点击 **"启动冗余备份..."** 按钮，然后查看文件是否已经从**D:\imagebk** 拷贝到了 **W:\wd-test.**



**支持**: support@lomorage.com or lomorage@gmail.com.

或者加 **微信：**，加入微信群，和开发者互动。

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/lomorage_wechat_qr.jpg
">
</p>
</div> 
