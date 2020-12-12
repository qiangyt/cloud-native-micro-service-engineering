```shell
BOX_NAME=ubuntu18-20201211
BOX_FILE=engineer365-${BOX_NAME}.box
```

1. 制作vagrant box的基础镜像

```shell
vagrant up

vagrant package --output ${BOX_FILE}
vagrant box add ${BOX_FILE} --name engineer365/${BOX_NAME} --force
vagrant destroy
```

2. 也可以跳过步骤#1，直接从我们的镜像网站下载并添加ubuntu18/engineer365的vagrant box
   
```shell
DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365
wget --quiet "${DOWNLOAD_SITE}/vagrant/box/${BOX_FILE}"
vagrant box add ${BOX_FILE} --name engineer365/${BOX_NAME} --force
rm ${BOX_FILE}
```
