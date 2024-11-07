#!/bin/bash

sudo file -s /dev/xvdf


sudo mkfs -t ext4 /dev/xvdf

or 

sudo mke4fs -t ext4 /dev/xvdf

sudo mkdir /mnt/new-vol


sudo mount /dev/xvdf /mnt/new-vol


sudo rsync -axv / /mnt/new-vol/


sudo grub-install --root-directory=/mnt/new-vol/ --force /dev/xvdf


sudo umount /mnt/new-vol

blkid

/dev/xvda1: 
LABEL="cloudimg-rootfs" 
UUID="263dc91a-fc69-2314-cdaf-23cabc336a24" 
TYPE="ext4" PTTYPE="dos"


sudo tune2fs -U UUID_OF_ORIGINAL_VOLUME /dev/xvdf;



sudo e2label /dev/xvda1

The output would look something like
"cloudimg-rootfs"


sudo e2label /dev/xvdf cloudimg-rootfs
