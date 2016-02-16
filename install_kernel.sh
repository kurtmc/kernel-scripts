#!/bin/bash

# Functions and variables
source config.sh

# Check if root
if [ "$EUID" -ne 0 ]; then
	echo "Can only install kernel as root"
	exit
fi

pre-install

make modules_install

# Read KERNELRELEASE from include/config/kernel.release (if it exists) (This line is stolen from the linux kernel Makefile)
KERNELRELEASE=$(cat include/config/kernel.release 2> /dev/null)

# copy image to /boot
cp -v arch/x86/boot/bzImage /boot/vmlinuz_$KERNELRELEASE

# make initial RAM disk
mkinitcpio -k /boot/vmlinuz_$KERNELRELEASE -c /etc/mkinitcpio.conf -g /boot/initramfs_$KERNELRELEASE.img

# update /boot/syslinux/syslinux.cfg
echo "
LABEL $KERNELRELEASE
	MENU LABEL $KERNELRELEASE
	LINUX ../vmlinuz_$KERNELRELEASE
	APPEND root=$ROOT_DEV rw
	INITRD ../initramfs_$KERNELRELEASE.img" >> /boot/syslinux/syslinux.cfg

post-install
