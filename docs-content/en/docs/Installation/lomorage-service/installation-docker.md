---
title: Docker
weight: 6
---

# Docker installation

Please refer to [lomo-docker](https://github.com/lomorage/lomo-docker) for installation with docker image. You can either use the arm image "lomorage/raspberrypi-lomorage:latest" or amd64 image "lomorage/amd64-lomorage:latest" based on the host architecture.

Below is an example to run lomo-docker on Raspberry Pi OS (64-bit) with desktop.

docker-compose.yml:

```
version: "3.9"
services:
  lomo:
    image: ${IMG}
    container_name: lomorage
    privileged: true
    environment:
      - LOMOD_DISABLE_MOUNT_MONITOR=1
    cap_add:
      - ALL
    volumes:
      - ${HOME_MEDIA_DIR}:/media/WD_36AA8D42AA8D001B
      - ${HOME_MEDIA_BAKUP_DIR}:/media/WD_90C27F73C27F5C82
      - ${HOME_LOMO_DIR}:/lomo
      - /dev:/dev
    ports:
      - ${LOMOD_PORT}:${LOMOD_PORT}
      - 8004:8004
    command: $LOMOD_PORT

  watchtower:
    image: ${AUTO_UPDATE_IMG}
    container_name: watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: lomorage --cleanup
```

.env file:

```
IMG=lomorage/arm64-lomorage:latest
AUTO_UPDATE_IMG=containrrr/watchtower:arm64v8-latest

# IMG=lomorage/amd64-lomorage:latest
# AUTO_UPDATE_IMG=containrrr/watchtower:amd64-latest

LOMOD_PORT=8000

# change the directories in your env
HOME_MEDIA_DIR="/media/jeromy/My Passport1"
HOME_MEDIA_BAKUP_DIR="/media/jeromy/My Passport"
HOME_LOMO_DIR="/home/jeromy/lomo"

# mdns works in vlan, change vlan settings in your env
NETWORK_TYPE=ipvlan # macvlan
NETWORK_INF=eth0
SUBNET=192.168.1.0/24
GATEWAY=192.168.1.1
VLAN_ADDR=192.168.1.79
```