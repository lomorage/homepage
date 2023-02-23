+++
title = "Set WD MyCloud as Lomorage redundancy backup disk on Windows"
tags = ["WD", "MyCloud", "Redundancy"]
categories = ["BLOG"]
date = "2023-02-22T13:43:40"
banner = "/img/blog/set_wd_as_backup/set_wd_as_backup.jpg"
+++

  **Setup WD MyCloud as Lomorage Redundancy backup disk on Windows.**
  
<!--more--> 


Table of Contents
=================
- [Table of Contents](#table-of-contents)
- [1. Mount WD MyCloud as Windows Disk](#1-mount-wd-mycloud-as-windows-disk)
- [2. Setup Redundancy Backup](#2-setup-redundancy-backup)
- [3. Test redundancy backup and trouble shooting](#3-test-redundancy-backup-and-trouble-shooting)
  - [If you meet some issue like the below:](#if-you-meet-some-issue-like-the-below)
  - [Solution is:](#solution-is)



# 1. Mount WD MyCloud as Windows Disk

The detail introduction from WD is here: __[How to mount WD MyCloud on Windows](https://support-en.wd.com/app/answers/detailweb/a_id/25436/h/p2#subject2)__

Below picture is my case:

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/set_wd_as_backup/mount.png" style="border:2px solid black;"  />
</p>
</div> 

# 2. Setup Redundancy Backup

 Open Lomorage Photo Assistant in your Windows, and set as blow:

 <div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/blog/set_wd_as_backup/set_redundancy_agent.png">
</p>
</div> 

# 3. Test redundancy backup and trouble shooting

And click the **"Start redundancy backup..."** button to see the files will copy from 
D:\imagebk to W:\wd-test.

## If you meet some issue like the below:

```
rdiff-backup.exe --force  -v5 --print-statistics D:/imagebk W:/
WARNING: this command line interface is deprecated and will disappear, start using the new one as described with '--new --help'.
* Using repository 'W:/'
NOTE: Found interrupted initial backup in data directory W:/rdiff-backup-data. Removing...
* Hardlinks disabled by default on Windows
* Unable to import module (py)xattr. Extended attributes not supported on filesystem at path D:/imagebk
* Unable to import module posix1e from pylibacl package. POSIX ACLs not supported on filesystem at path D:/imagebk
* -----------------------------------------------------------------
Detected abilities for source (read only) file system:
  Access control lists                         Off
  Extended attributes                          Off
  Windows access control lists                 On
  Case sensitivity                             Off
  Escape DOS devices                           On
  Escape trailing spaces                       On
  Mac OS X style resource forks                Off
  Mac OS X Finder information                  Off
-----------------------------------------------------------------
* Directories on file system at path W:/rdiff-backup-data/rdiff-backup.tmp.0 are not fsyncable. Assuming it's unnecessary.
* Unable to import module (py)xattr. Extended attributes not supported on filesystem at path W:/rdiff-backup-data/rdiff-backup.tmp.0
* Unable to import module posix1e from pylibacl package. POSIX ACLs not supported on filesystem at path W:/rdiff-backup-data/rdiff-backup.tmp.0
* -----------------------------------------------------------------
Detected abilities for destination (read/write) file system:
  Ownership changing                           Off
  Hard linking                                 On
  fsync() directories                          Off
  Directory inc permissions                    Off
  High-bit permissions                         On
  Symlink permissions                          Off
  Extended filenames                           On
  Windows reserved filenames                   On
  Access control lists                         Off
  Extended attributes                          Off
  Windows access control lists                 On
  Case sensitivity                             Off
  Escape DOS devices                           On
  Escape trailing spaces                       On
  Mac OS X style resource forks                Off
  Mac OS X Finder information                  Off
-----------------------------------------------------------------
* Backup: escape_dos_devices = False
* Backup: escape_trailing_spaces = False
* Enabled use_compatible_timestamps
NOTE: Symbolic links excluded by default on Windows
* Given repository doesn't need to be regressed
NOTE: Starting mirror from source path D:/imagebk to destination path W:/
* Processing file .
* Processing file .WDSyncHistory
* Processing file .WDSyncHistory/.WD Hidden Files
* Processing file Garbage Dispenser2.mp4
* Cleaning up
Traceback (most recent call last):
  File "rdiffbackup\run.py", line 170, in <module>
  File "rdiffbackup\run.py", line 37, in main
  File "rdiffbackup\run.py", line 105, in main_run
  File "rdiffbackup\actions\backup.py", line 159, in run
  File "rdiff_backup\backup.py", line 39, in mirror_compat200
  File "rdiff_backup\backup.py", line 197, in patch
  File "rdiff_backup\rorpiter.py", line 142, in __call__
  File "rdiff_backup\rorpiter.py", line 179, in _finish_branches
  File "rdiff_backup\backup.py", line 641, in end_process_directory
  File "rdiff_backup\rpath.py", line 807, in rmdir
PermissionError: [WinError 5] Access is denied: b'W:/.WDSyncHistory/.WD Hidden Files'
[2528] Failed to execute script 'run' due to unhandled exception!

```

## Solution is:

**Please go to W:\wd-test,  to remove some hidden files.**

**Support**: support@lomorage.com or lomorage@gmail.com.