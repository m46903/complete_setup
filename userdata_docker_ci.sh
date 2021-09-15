#!/bin/bash
    yum install -y yum-utils
	yum-config-manager --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	yum install docker-ce docker-ce-cli containerd.io -y
	systemctl start docker
    hostnamectl set-hostname caasp-build-01
    yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
    yum install postgresql12 -y
    curl -O https://bootstrap.pypa.io/get-pip.py
    python get-pip.py --user
    export PATH=~/.local/bin:$PATH
    source ~/.bash_profile
    pip install awscli
    