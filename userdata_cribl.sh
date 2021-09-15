#!/bin/bash
    hostname caasp-splunk-hf
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html
    echo "<html><h1>Cribl: splunk heavy_forwarder -- private subnet.</h1></html>" > index.html