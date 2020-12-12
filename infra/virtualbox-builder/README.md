1. 制作store 1的vagrant box

```shell
vagrant up

vagrant package --output engineer365_store1.box 
vagrant box add engineer365_store1.box --name engineer365/store1 --force
vagrant destroy
```

2. 也可以跳过步骤#1，直接从我们的镜像网站下载并添加engineer365/store1的vagrant box
   
```shell
DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365
ENGINEER365_STORE1_BOX=engineer365_store1.box
wget --quiet "${DOWNLOAD_SITE}/vagrant/box/${ENGINEER365_STORE1_BOX}"
vagrant box add ${ENGINEER365_STORE1_BOX} --name engineer365/store1 --force
rm ${ENGINEER365_STORE1_BOX}
```
