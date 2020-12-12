#!/bin/bash

set -e
set -x

DOWNLOAD_SITE=https://download.wxcount.com:8443/engineer365

docker pull openjdk:11.0.9.1-jre
docker pull openjdk:11.0.9.1-jdk
docker pull maven:3.6.3-jdk-11
