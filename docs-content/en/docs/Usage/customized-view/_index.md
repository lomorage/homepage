---
weight: 14
title: "Customized View"
---

# Customized View

Lomorage saves photos/videos on disk in YYYY/MM/DD folder structure, and some users would prefer to have other folder structures like YYYY/MM or even YYYY,  some users even would like to have more meaningful folder names so that the assets can be organized like albums.

Lomorage solves the above problems by providing virtual views, which means it can provides multiple virtual views without affecting the physical folder structures on hard drive.

The physical folder structure:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-physical-folder-structure.png">
</p>

After changing the customized view to "Year":

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-virtual-folder-structure-year.png">
</p>

After changing the customized view to "Year/Month":

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-virtual-folder-structure-year-month.png">
</p>

And there is an "Albums" folder, which shows the ablums you created using Lomorage iOS/Android APP:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/lomorage-virtual-folder-structure-albums.png">
</p>

You can change the "customized view" either via Mac/Windows "Lomorage Photo Assistant":

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/osx-customize-view-menu.png">
</p>

Windows:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/win-customize-view-menu.png">
</p>

Or via Lomorage iOS/Android APP if you are using "Lomorage Photo Assistant in other platforms other than Mac/Windows:

<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/ios-customize-view-menu.png">
</p>

Android:
<p class="screenshoot">
  <img width="50%" src="/img/installation/customized-view/android-customize-view-menu.png">
</p>

Once you changed the "customized view", you can mount the "customized view" on Windows/Mac. If you are using Mac/Windows "Lomorage Photo Assistant", this is done for you automatically once you change "customized view" and the mounted directory will pop up once change is done. If you are using "Lomorage Photo Assistant in other platforms other than Mac/Windows, you can mount it by yourself following the instruction below, Lomorage uses WebDAV protocol and expose it via "http://[lomorage-assistant-ip]:8004" (no password needed).

- MacOS: https://support.apple.com/guide/mac-help/connect-disconnect-a-webdav-server-mac-mchlp1546/mac
- Windows: https://www.thewindowsclub.com/how-to-map-webdav-in-windows
