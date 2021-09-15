#!/bin/bash
    hostname cribl_test2
    #yum update -y         #Takes a long time to run
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    mkdir /var/www/html
    cd /var/www/html
    echo "<html><h1>Cribl2: cribl_test2.</h1></html>" > index.html
    