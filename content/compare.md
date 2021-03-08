+++
title = "Price Comparison"
description = "Price comparison Lomorage with Similar products"
keywords = ["Price","Compare","Google Photo","iCloud", "Amazon Photo", "NAS", "Synology", "QNAP", "ibi", "Monument", "Kwilt3"]
+++

# Price Comparison

**The following comparison only considered the biggest selling point for each category, and assuming the main purpose is photo backup and photo management, so if you need more than that, just go with NAS, or get Orange Pi Zero or other single board computer to DIY yourself if you are expert.**

**We are not against cloud storage, it can be as good backup for local storage, and we suggest user keep the local copy.**

For example, the cloud service has different price by storage size, there are other features but it actually makes no difference with different storage sizes; And for the self hosting devices, the price differs by the hardware configurations, there are other features but it actually makes no difference with different configurations. Among all the features, backup is the fundamental requirements, and all other fancy features is built on that.

Lomorage is more cost efficient and more flexible compared with existing solutions, the software cost you nothing, and even get the hardware setup using Orange Pi Zero is cheaper.  If you use the Windows or Mac application, it's $0. There are some features currently missing but they are planned, and the basic backup feature is solid and stable for almost 2 years, no hidden fees, no lock down, no privacy concern, why not give it a try?

## Compare with cloud service

The following are **yearly fees**,  those cells leave blank are not available, for example, Apple iCloud only provides 5 GB, 50 GB, 200 GB and 2 TB options, for Lomorage, it would be hard to get new hard drive smaller than 500 GB nowadays.

Lomorage software is 100% free for the the essential functions, thus here will only take device and energy cost into account, and yearly cost is calculated as [depreciation expense](https://www.profitbooks.net/what-is-depreciation/). See below for more details.

{{<table "table table-striped table-bordered">}}
|        | Lomorage (2-Bays) yearly fee<br />assuming upgrade every 4 years | Apple iCloud |   Google Photo   | Amazon Photo | OneDrive |
| -----: | -------- | ------------ | ---------------- | ------------ | --------- |
|   5 GB |          | Free         |                  | Free         | Free      |
|  15 GB |          |              | Free             |              |           |
|  50 GB |          | $ 11.88      |                  |              |           |
| 100 GB |          |              | $ 19.99          | $ 19.99      | $ 23.88   |
| 200 GB |          | $ 35.88      | $ 29.99          |              |           |
| 500 GB | $ 33.52  |              |                  |              |           |
|   1 TB | $ 42.89  |              |                  | $ 59.99      | $ 69.99   |
|   2 TB | $ 47.53  | $ 119.88     | $ 99.99          | $ 119.98     |           |
|   3 TB | $ 55.03  |              |                  | $ 179.97     |           |
|   4 TB | $ 65.03  |              |                  | $ 239.96     |           |
|   6 TB | $ 95.02  |              |                  | $ 359.94     | $ 99.99 (1 TB/person) |
|   8 TB | $ 115.02 |              |                  | $ 479.92     |           |
{{</table>}}

Since Lomorage users will use their own hard drive, according to the research published [here](https://www.prosofteng.com/blog/how-long-do-hard-drives-last), 

> Generally speaking, you can rely on your hard drive for three to five years on average. The online backup company BackBlaze analysed the failure rates of their 25,000 running hard drives. They found that 90% of hard drives survive for three years, and 80% for four years. But this number varied across brands. Western Digital and Hitachi hard drives lasted much longer than Seagate’s in Backblaze’s [study](https://www.backblaze.com/blog/how-long-do-disk-drives-last/).

Assuming the average of hard drive use for 4 years,  and setup duplicate backup to ensure safety. So the price for storage price per year will be `hard drive * 2 / 4`, and let's assume you upgrade it for more powerful and efficient one every 4 years like computer, plus the extra USB hub which assuming last 4 years. The equipment cost per year will be `(hard drive * 2 + Orange Pi Zero + usb hub) / 4 `,  plus the $5 energy cost per year, the total cost will be `(hard drive * 2 + Orange Pi Zero + usb hub) / 4  + 5` per year.

The [Orange Pi Zero](https://www.aliexpress.com/item/4001117923064.html?spm=2114.12010615.8148356.5.2988111fCvoZ8G) includes:

- Orange Pi Zero LTS 512MB
- Protective White Case
- OTG Power Supply

USB hub with power supply:

- [Plugable USB 2.0 7-Port High Speed Hub with 15W Power Adapter](https://www.walmart.com/ip/Plugable-USB-Hub-USB-2-0-7-Port-15W/134245816)
- [USB 2.0 Powered Hub - 7 Ports with 5V 2A Power Supply](https://www.adafruit.com/product/961)

MicroSD Card

- [SanDisk Ultra 16GB](https://www.amazon.com/SanDisk-Ultra-Micro-Adapter-SDSQUNC-016G-GN6MA/dp/B010Q57SEE/ref=sr_1_26?dchild=1&keywords=sd+card&qid=1615094086&refinements=p_n_feature_two_browse-bin%3A6518303011&rnid=172282&s=pc&sr=1-26)

{{<table "table table-striped table-bordered">}}
| storage/drive | Hard drive  (1 drive) | Lomorage | Yearly Fee | Total devices expense (2 drives) |
| ------ | ----------- | ----------- | ---------- | --------------------- |
| 500 GB | $ 36.99 x 2 | $ 60.13     | $ 33.52    | $ 134.10              |
| 1 TB   | $ 55.72 x 2 | $ 60.13     | $ 42.89    | $ 171.57              |
| 2 TB   | $ 64.99 x 2 | $ 60.13     | $ 47.53    | $ 190.11              |
| 3 TB   | $ 79.99 x 2 | $ 60.13     | $ 55.03    | $ 220.11              |
| 4 TB   | $ 99.99 x 2 | $ 60.13     | $ 65.03    | $ 260.11              |
| 6 TB   | $ 79.99 x 4 | $ 60.13     | $ 95.02    | $ 380.09              |
| 8 TB   | $ 99.99 x 4 | $ 60.13     | $ 115.02   | $ 460.09              |
{{</table>}}

## Compare with self hosting

It's unfair to compare a NAS with tons of features with dedicated device design for photo, but if you want just the feature related to Photo, why bother NAS if the dedicated device can do better?

{{<table "table table-striped table-bordered">}}
|                                       | Two-bay Disk Free | Two-bay 4 TB | One-bay 1TB |
| ------------------------------------- | ----------------- | ------------ | ----------- |
| Lomorage                              | $ 60.13 | $ 190.11 | $ 93.9 |
| Synology 2 bay NAS DiskStation DS218+ | $ 299.99          |  |             |
| QNAP TS-231P-US Personal Cloud        | $ 169             |              |             |
| My Cloud Home Duo                     |                   | $ 279.99     |             |
| ibi - The Smart Photo Manager         |                   |              | $ 119.99    |
| Monument Photo Management Device      | $ 169.94          |              |             |
| Kwilt3 Personal Cloud Storage Device  | $ 99              |              |             |
{{</table>}}