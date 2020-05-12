+++
title = "Price Comparison"
description = "Price comparison Lomorage with Similar products"
keywords = ["Price","Compare","Google Photo","iCloud", "Amazon Photo", "NAS", "Synology", "QNAP", "ibi", "Monument", "Kwilt3"]
+++

# Price Comparison

**The following comparison only considered the biggest selling point for each category, and assuming the main purpose is photo backup and photo management, so if you need more than that, just go with NAS, or get Raspberry Pi 4 or other single board computer to DIY yourself if you are expert.**

For example, the cloud service has different price by storage size, there are other features but it actually makes no difference with different storage sizes; And for the self hosting devices, the price differs by the hardware configurations, there are other features but it actually makes no difference with different configurations. Among all the features, backup is the fundamental requirements, and all other fancy features is built on that.

Lomorage is more cost efficient and more flexible compared with existing solutions, the software cost you nothing, and even get the hardware setup using Raspberry Pi 4 is cheaper.  If you use the Windows or Mac application, it's $0. There are some features currently missing but they are planned, and the basic backup feature is solid and stable for almost 2 years, no hidden fees, no lock down, no privacy concern, why not give it a try?

## Compare with cloud service

The following are **yearly fees**,  those cells leave blank are not available, for example, Apple iCloud only provides 5 GB, 50 GB, 200 GB and 2 TB options, for Lomorage, it would be hard to get new hard drive smaller than 500 GB nowadays.

Lomorage software is 100% free for the the essential functions, thus here will only take device and energy cost into account, and yearly cost is calculated as [depreciation expense](https://www.profitbooks.net/what-is-depreciation/). See below for more details.

{{<table "table table-striped table-bordered">}}
|        | Lomorage | Apple iCloud |   Google Photo   | Amazon Photo | OneDrive |
| -----: | -------- | ------------ | ---------------- | ------------ | --------- |
|   5 GB |          | Free         |                  | Free         | Free      |
|  15 GB |          |              | Free             |              |           |
|  50 GB |          | $ 11.88      |                  |              |           |
| 100 GB |          |              | $ 19.99          | $ 19.99      | $ 23.88   |
| 200 GB |          | $ 35.88      | $ 29.99          |              |           |
| 500 GB | $ 45.18  |              |                  |              |           |
|   1 TB | $ 54.55  |              |                  | $ 59.99      | $ 69.99   |
|   2 TB | $ 59.18  | $ 119.88     | $ 99.99          | $ 119.98     |           |
|   3 TB | $ 66.68  |              |                  | $ 179.97     |           |
|   4 TB | $ 76.68  |              |                  | $ 239.96     |           |
|   6 TB | $ 106.68 |              |                  | $ 359.94 | $ 99.99 (1 TB/person) |
|   8 TB | $ 126.68 |              |                  | $ 479.92     |           |
{{</table>}}

Since Lomorage users will use their own hard drive, according to the research published [here](https://www.prosofteng.com/blog/how-long-do-hard-drives-last), 

> Generally speaking, you can rely on your hard drive for three to five years on average. The online backup company BackBlaze analysed the failure rates of their 25,000 running hard drives. They found that 90% of hard drives survive for three years, and 80% for four years. But this number varied across brands. Western Digital and Hitachi hard drives lasted much longer than Seagate’s in Backblaze’s [study](https://www.backblaze.com/blog/how-long-do-disk-drives-last/).

Assuming the average of hard drive use for 4 years,  and setup duplicate backup to ensure safety. So the price for storage price per year will be `hard drive * 2 / 4`, and Raspberry Pi most likely will [last for 10 years](https://www.raspberrypi.org/forums/viewtopic.php?t=2856), but let's assume you upgrade it for more powerful and efficient one every 4 years like computer, plus the extra USB hub which assuming last 4 years. The equipment cost per year will be `(hard drive * 2 + Raspberry Pi suite + usb hub) / 4 `,  plus the [$ 5 energy cost](https://raspberrypi.stackexchange.com/questions/5033/how-much-energy-does-the-raspberry-pi-consume-in-a-day) per year, the total cost will be `(hard drive * 2 + Raspberry Pi suite + usb hub) / 4  + 5` per year.

The [Raspberry Pi 4 Starter Kit](https://www.pishop.us/product/raspberry-pi-4-model-b-2gb/?src=raspberrypi) includes:

- Raspberry Pi 4 Model B/2GB
- HighPi Raspberry Pi Case for Pi4
- USB-C Power Supply, 5.1V 3.0A
- 16 GB microSD Card
- Aluminum Heatsink 

USB hub with power supply:

- [Plugable USB 2.0 7-Port High Speed Hub with 15W Power Adapter](https://www.walmart.com/ip/Plugable-USB-Hub-USB-2-0-7-Port-15W/134245816)
- [USB 2.0 Powered Hub - 7 Ports with 5V 2A Power Supply](https://www.adafruit.com/product/961)

{{<table "table table-striped table-bordered">}}
| storage/drive (2 drives) | Hard drive  | Raspberry Pi 4 Starter Kit | USB hub | Yearly Fee | Total devices expense |
| ------ | ----------- | -------------------------- | ------- | ---------- | --------------------- |
| 500 GB | $ 36.99     | $ 64.80                    | $ 21.95 | $ 45.18    | $ 160.73              |
| 1 TB   | $ 55.72     | $ 64.80                    | $ 21.95 | $ 54.55    | $ 198.19              |
| 2 TB   | $ 64.99     | $ 64.80                    | $ 21.95 | $ 59.18    | $ 216.73              |
| 3 TB   | $ 79.99     | $ 64.80                    | $ 21.95 | $ 66.68    | $ 246.73              |
| 4 TB   | $ 99.99     | $ 64.80                    | $ 21.95 | $ 76.68    | $ 286.73              |
| 6 TB   | $ 79.99 x 2 | $ 64.80                    | $ 21.95 | $ 106.68   | $ 406.71              |
| 8 TB   | $ 99.99 x 2 | $ 64.80                    | $ 21.95 | $ 126.68   | $ 486.71              |
{{</table>}}

## Compare with self hosting

It's unfair to compare a NAS with tons of features with dedecated device design for photo, but if you want just the feature related to Photo, why bother NAS if the dedecated device can do better?

{{<table "table table-striped table-bordered">}}
|                                       | Two-bay Disk Free | Two-bay 4 TB | One-bay 1TB |
| ------------------------------------- | ----------------- | ------------ | ----------- |
| Lomorage                              | (Raspberry Pi 4 starter kit + power USB hub)<br /><br />$ 86.75 | (Raspberry Pi 4 starter kit + power USB hub + 2 x 2 TB)<br /><br />$ 216.73 | (Raspberry Pi 4 starter kit + 1 TB)<br /><br />$ 120.52 |
| Synology 2 bay NAS DiskStation DS218+ | $ 299.99          |  |             |
| QNAP TS-231P-US Personal Cloud        | $ 169             |              |             |
| My Cloud Home Duo                     |                   | $ 279.99     |             |
| ibi - The Smart Photo Manager         |                   |              | $ 119.99    |
| Monument Photo Management Device      | $ 169.94          |              |             |
| Kwilt3 Personal Cloud Storage Device  | $ 99              |              |             |
{{</table>}}