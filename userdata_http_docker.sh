#!/bin/bash
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html
    echo "<html><h1>Docker host.</h1></html>" > index.html
    yum install -y yum-utils
	yum-config-manager --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
	yum install docker-ce docker-ce-cli containerd.io -y
	systemctl start docker