注：以下命令暂时仅支持ubuntu，其它操作系统请参照着改动。可下载到文件可以参见https://download.wxcount.com:8443/engineer365/


## 准备工作

```shell
DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365
sudo mkdir /data/ && sudo chown -R $USER:$USER /data/
cd /data/
```

## 安装VirtualBox

   https://www.virtualbox.org

```shell
VIRTUALBOX_DEB=virtualbox-6.1_6.1.14-140239_Ubuntu_$(lsb_release -cs)_amd64.deb
wget --quiet "${DOWNLOAD_SITE}/virtualbox/${VIRTUALBOX_DEB}"
sudo dpkg -i ${VIRTUALBOX_DEB}
sudo apt --fix-broken install
rm ${VIRTUALBOX_DEB}
```

## 安装vagrant
   
   https://www.vagrantup.com/intro

```shell
VAGRANT_DEB=vagrant_2.2.14_x86_64.deb
wget --quiet "${DOWNLOAD_SITE}/vagrant/${VAGRANT_DEB}"
sudo dpkg -i ${VAGRANT_DEB}
rm ${VAGRANT_DEB}

sudo echo 'export VAGRANT_EXPERIMENTAL="disks"' >> /etc/profile
source /etc/profile

vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-disksize
```


1. 从vagrant官网添加ubuntu/bionic64的vagrant box
   
   这一步是从vagrant官网添加vagrant box，然后导出保存到我们的镜像
   网站的步骤，非常耗时。
   因此，可以跳到下一步，直接从镜像网站下载。

```shell
vagrant box add ubuntu/bionic64
vagrant box repackage ubuntu/bionic64 virtualbox 20201201.0.0
mv package.box ubuntu-bionic.box
```

2. 从我们的镜像网站下载并添加ubuntu/bionic64的vagrant box
   
```shell
UBUNTU_BIONIC_BOX=ubuntu-bionic.box
wget --quiet "${DOWNLOAD_SITE}/vagrant/box/${UBUNTU_BIONIC_BOX}"
vagrant box add ${UBUNTU_BIONIC_BOX} --name ubuntu/bionic64 --force
rm ${UBUNTU_BIONIC_BOX}
```
