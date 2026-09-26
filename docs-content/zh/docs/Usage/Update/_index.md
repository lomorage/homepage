---
title: 手工升级Lomoarge后台系统
weight: 11
---

# 手工升级Lomoarge后台系统

如果您碰到您的Lomorage后台系统不能自动升级，请尝试下面手工升级的方法

## 1. 确认您使用了正确的Lomoware源

使用ssh 工具登录您的树莓派或者liux系统。
您可以google或者百度 **如何使用ssh**

比如：您的树莓派系统的IP地址是： 192.168.1.162，可以在Windows的终端输入：

```bash
ssh pi@192.168.1.162
pi@192.168.1.162's password:
```

**默认密码是 raspberry**

连接成功后，输入：

```bash
cat /etc/apt/sources.list.d/lomoware.list
```

显示结果如下：

```bash
deb [trusted=yes] https://lomoware.lomorage.com/debian/bookworm bookworm main
```

**如果中间的网址不是 lomoware.lomorage.com 那请按如下方法更改**, 否则跳到**步骤2直接开始升级**

在ssh 终端输入：

```bash
sudo nano  /etc/apt/sources.list.d/lomoware.list
```

按下面的图中更改，

<div align="center">
<p class="screenshoot">
  <img width="100%" src="/img/installation/update/change_source.png">
</p>
</div>

> 然后按 **ctrl + X**

> 接着按 **Y**  保存您的更改

## 2. 在 ssh 终端输入以下命令开始升级

```bash
sudo apt update && sudo apt install lomo-backend
```

### 如果 `apt update` 报签名错误 (NO_PUBKEY / GPG error)

如果您看到类似下面的错误：

```
W: GPG error: https://lomoware.lomorage.com/debian/bookworm bookworm InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY xxxxxxxxxxxxxxxx
```

这说明我们更新了源的签名密钥（比如旧密钥丢失需要更换），而您的系统里还是旧的密钥。重新执行一遍安装密钥的步骤即可：

```bash
sudo apt install -y ca-certificates
sudo update-ca-certificates --fresh
curl -fsSL https://lomoware.lomorage.com/debian/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/lomorage-apt-key.gpg > /dev/null
```

然后重新运行第2步的升级命令。

**注意**：如果您的 `/etc/apt/sources.list.d/lomoware.list` 里的内容是 `deb [trusted=yes] ...`（带 `[trusted=yes]`），说明这台设备本来就跳过了签名校验，不会碰到这个问题，也不需要执行上面的步骤。

## 3. 在手机端 设置 页面 查看您的服务器信息，确保升级成功

如果升级过程中遇到问题，请发邮件至 [support@lomorage.com](mailto:support@lomorage.com)。
