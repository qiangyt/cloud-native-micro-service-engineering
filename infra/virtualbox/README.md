## 注：
  - 需要一台物理机器。因为第一阶段是使用Ansible + Vagrant + VirtualBox虚拟机，每台虚拟机内存设置为4GB，所以建议32G内存，或者需修改Vagrantfile、降低内存大小设置
  - Ubuntu：以下步骤都是在Ubuntu 20上开发测试完成，其它较新Ubuntu版本(16~19)未验证，但应该也没问题。其它Linux需要稍稍改动
  - Mac OS X: 未测试，需要改动
  - Windows：暂不支持其它操作系统请参照着改动。
  
## 准备工作

   所用到的部分软件和包的下载：https://download.wxcount.com:8443/engineer365/
  
   ```shell
   DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365
   sudo mkdir /data/ && sudo chown -R $USER:$USER /data/
   cd /data/
   ```

## 安装ansible
  
   https://www.ansible.com

   https://www.ansible.com.cn

   Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy and maintain. Automate everything from code deployment to network configuration to cloud management, in a language that approaches plain English, using SSH, with no agents to install on remote systems. https://docs.ansible.com.

   ```shell
   $ sudo apt-get install software-properties-common
   $ sudo apt-add-repository ppa:ansible/ansible
   $ sudo apt-get update
   $ sudo apt-get install ansible
   ```

## 安装VirtualBox

   https://www.virtualbox.org

```shell
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
sudo apt-get install -y linux-headers-$(uname -r) build-essential gcc make python zip cmake uuid tree jq

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
# Installed the plugin 'vagrant-vbguest (0.28.0)'!

vagrant plugin install vagrant-disksize
# Installed the plugin 'vagrant-disksize (0.1.3)'!
```




