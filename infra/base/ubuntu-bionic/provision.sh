#!/bin/bash

#set -e
set -x

#cp /home/vagrant/sources.list /etc/apt/  

DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365

apt-get update
apt-get -y upgrade

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

apt-get install -y linux-headers-$(uname -r) build-essential gcc make python zip cmake uuid tree jq

# install docker ---------------------------------------------------------------
mkdir /etc/docker/
cp /home/vagrant/daemon.json /etc/docker/

# https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.3.9-1_amd64.deb
CONTAINERD_DEB=containerd.io_1.3.9-1_amd64.deb
wget --quiet "${DOWNLOAD_SITE}/docker/${CONTAINERD_DEB}"
dpkg -i ${CONTAINERD_DEB}
rm ${CONTAINERD_DEB}

# https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_19.03.14~3-0~ubuntu-bionic_amd64.deb
DOCKER_CLI_DEB=docker-ce-cli_19.03.14~3-0~ubuntu-bionic_amd64.deb
wget --quiet "${DOWNLOAD_SITE}/docker/${DOCKER_CLI_DEB}"
dpkg -i ${DOCKER_CLI_DEB}
rm ${DOCKER_CLI_DEB}

# https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_19.03.14~3-0~ubuntu-bionic_amd64.deb
DOCKER_DEB=docker-ce_19.03.14~3-0~ubuntu-bionic_amd64.deb
wget --quiet "${DOWNLOAD_SITE}/docker/${DOCKER_DEB}"
dpkg -i ${DOCKER_DEB}
rm ${DOCKER_DEB}

# https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64
DOCKER_COMPOSE_BINARY=docker-compose-Linux-x86_64-1.27.4
curl --silent -L "${DOWNLOAD_SITE}/docker/${DOCKER_COMPOSE_BINARY}" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose

#tee /etc/docker/daemon.json <<-'EOF'
# {
#   "registry-mirrors": ["https://77fpelpm.mirror.aliyuncs.com"]
# }
#EOF

systemctl daemon-reload
systemctl restart docker

#apt autoremove

## set up users: "admin", "dev" ------------------------------------------------
ORG_GROUP="engineer365"
groupadd ${ORG_GROUP}
echo "AllowGroups root vagrant ${ORG_GROUP}" >> /etc/ssh/sshd_config
#sed -i -e "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
systemctl restart ssh

## set up user: "admin"
ADMIN_USER="admin"

useradd -g ${ADMIN_USER} --home-dir /home/${ADMIN_USER} --create-home --shell /bin/bash ${ADMIN_USER}
usermod -aG sudo ${ADMIN_USER}
usermod -aG docker ${ADMIN_USER}

# echo "${ADMIN_USER}  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "${ADMIN_USER}  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/${ADMIN_USER}

mkdir -p /home/${ADMIN_USER}/.ssh
ssh-keygen -P "" -t rsa -C "${ADMIN_USER}@${ORG_GROUP}" -f /home/${ADMIN_USER}/.ssh/id_rsa
cat /home/${ADMIN_USER}/.ssh/id_rsa.pub >> /home/${ADMIN_USER}/.ssh/authorized_keys 
chown -R ${ADMIN_USER}:${ADMIN_USER} /home/${ADMIN_USER}/.ssh

## set up user: "dev"
DEV_USER="dev"

useradd --user-group --home-dir /home/${DEV_USER} --create-home --shell /bin/bash ${DEV_USER}
usermod -aG sudo ${DEV_USER}
usermod -aG docker ${DEV_USER}

echo "${DEV_USER}  ALL=(ALL) NOPASSWD:/usr/bin/docker,/usr/local/bin/docker-compose" | tee /etc/sudoers.d/${DEV_USER}

mkdir -p /home/${DEV_USER}/.ssh
ssh-keygen -P "" -t rsa -C "${DEV_USER}@${ORG_GROUP}" -f /home/${DEV_USER}/.ssh/id_rsa
cat /home/${DEV_USER}/.ssh/id_rsa.pub >> /home/${DEV_USER}/.ssh/authorized_keys 
chown -R ${DEV_USER}:${DEV_USER} /home/${DEV_USER}/.ssh

rm /home/vagrant/daemon.json
rm /home/vagrant/sources.list
