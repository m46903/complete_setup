#!/bin/bash
    hostname caasp-splunk-hf
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html
    echo "<html><h1>Splunk heavy_forwarder.</h1></html>" > index.html