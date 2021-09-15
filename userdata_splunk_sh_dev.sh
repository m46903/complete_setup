#!/bin/bash
    mkfs.ext4 /dev/xvdd
    mkdir /opt/splunk
    mount /dev/xvdd /opt/splunk
    # Add following line manually in "/etc/fstab" file 
    # /dev/xvdd /opt/splunk ext4 defaults,nofail 0 0

    # umount /opt/splunk
    