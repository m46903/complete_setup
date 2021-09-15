#!/bin/bash
    mkfs.ext4 /dev/xvdd
    mkdir /opt/splunk
    mount /dev/xvdd /opt/splunk
    cd /etc
    echo "/dev/xvdd /opt/splunk ext4 defaults,nofail 0" > fstab
    # umount /opt/splunk
    