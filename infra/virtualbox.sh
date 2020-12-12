#!/bin/bash

# 
#  MIT License
# 
#  Copyright (c) 2020 engineer365.org
# 
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
# 
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
# 
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.

set -x

export org="engineer365"

export download_site="https://download.wxcount.com:8443/engineer365"
export upload_site=""
export box_download_path="${download_site}/vagrant/box"

# users
export admin_user="admin"
export dev_user="dev"

source $infra_dir/ip_and_host.sh
source $infra_dir/box_name.sh


function import_box() {
    local box_name=$1
    local box_name_fq="${org}/${box_name}"
    local box_file="${box_name}.box"

    rm -f ${box_file}
    wget --quiet "${box_download_path}/${org}/${box_file}"

    vagrant box add ${box_file} --name ${box_name_fq} --force

    rm ${box_file}
}

function export_box() {
    local box_name=$1
    local box_name_fq="${org}/${box_name}"
    local box_file="${box_name}.box"

    vagrant up

    rm -f ${box_file}
    vagrant package --output ${box_file}

    vagrant box add ${box_file} --name ${box_name_fq} --force
    vagrant destroy

    # upload to the mirror site
    scp -P 30022 ${box_file} 192.168.4.4:/volume1/public/download/engineer365/vagrant/box/${org}/
}
