1. 制作vagrant box的基础镜像

```shell
vagrant up

vagrant package
mv package.box ubuntu18_engineer365.box 
vagrant box add ubuntu18_engineer365.box --name ubuntu18/engineer365 --force
vagrant destroy
```

2. 也可以跳过步骤#1，直接从我们的镜像网站下载并添加ubuntu18/engineer365的vagrant box
   
```shell
DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365
UBUNTU18_ENGINEER365_BOX=ubuntu18_engineer365.box 
wget --quiet "${DOWNLOAD_SITE}/vagrant/box/${UBUNTU18_ENGINEER365_BOX}"
vagrant box add ${UBUNTU18_ENGINEER365_BOX} --name ubuntu18/engineer365 --force
rm ${UBUNTU18_ENGINEER365_BOX}
```
