# Install Lomorage Service on Armbian

Currently it supports Armbian Focal. If you have other needs please reach us for support.

```
sudo apt install -y ca-certificates python-certifi python3-certifi
sudo update-ca-certificates --fresh
wget -qO - https://raw.githubusercontent.com/lomoware/lomoware.github.io/master/debian/gpg.key | sudo apt-key add -
echo "deb https://lomoware.github.io/debian/focal focal main" | sudo tee /etc/apt/sources.list.d/lomoware.list
sudo apt update
sudo apt install lomo-base lomo-vips lomo-backend lomo-web -y
```