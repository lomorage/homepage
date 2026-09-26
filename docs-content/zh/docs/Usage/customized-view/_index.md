---
weight: 14
title: "自定义视图"
---

# 自定义视图

Lomorage按“年/月/日”的目录结构存储照片和视频，有些用户希望能按照“年/月”或者“年”的方式在电脑上浏览照片，有些用户希望能按更有意义的目录名来组织照片视频（自定义相册）。

Lomorage通过提供虚拟的视图来解决这个问题，它可以提供多种不同的视图来方便用户浏览照片，而不影响到在硬盘上的照片物理存储目录结构。

物理存储目录结构如下:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-physical-folder-structure.png">
</p>

修改自定义视图为"年":

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-virtual-folder-structure-year.png">
</p>

修改自定义视图为"年/月":

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-virtual-folder-structure-year-month.png">
</p>

您可能也注意到上面的截图中有“Albums”目录，这个目录存放的是您在手机APP上创建的相册:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-virtual-folder-structure-albums.png">
</p>

您可以通过Mac/Windows下的“Lomorage照片助手”来修改“自定义视图”:

Windows:

<p class="screenshoot">
  <img width="100%" src="/img/installation/customized-view/win-customize-view-menu-zh.png">
</p>

MacOS:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/osx-customize-view-menu-zh.png">
</p>

或者通过Lomorage手机APP来修改（如果您使用的是其他平台的“Lomorage照片助手”）:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/ios-customize-view-menu-zh.png">
</p>

安卓:
<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/android-customize-view-menu-zh.png">
</p>

再修改了“自定义视图”之后，您可以在Windows和Mac上加载“自定义视图”。如果您使用的是Mac/Windows下的“Lomorage照片助手”，会自动加载并弹出已经加载的目录。如果您使用其他平台的“Lomorage照片助手”，可以手动参考下面的链接来加载，Lomorage使用WebDAV协议，并通过"http://[Lomorage照片助手ip地址]:8004"访问，无需密码。

- MacOS: https://support.apple.com/zh-cn/guide/mac-help/mchlp1546/mac
- Windows: https://bynss.com/windows/501651.html
