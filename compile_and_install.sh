#!/bin/bash

# Read KERNELRELEASE from include/config/kernel.release (if it exists) (This line is stolen from the linux kernel Makefile)
KERNELRELEASE=$(cat include/config/kernel.release 2> /dev/null)

# copy image to /boot
cp -v arch/x86/boot/bzImage /boot/vmlinuz_$KERNELRELEASE

# make initial RAM disk
mkinitcpio -k $KERNELRELEASE -c /etc/mkinitcpio.conf -g /boot/initramfs_$KERNELRELEASE.img

# update /boot/syslinux/syslinux.cfg
echo "
LABEL $KERNELRELEASE
	MENU LABEL $KERNELRELEASE
	LINUX ../vmlinuz_$KERNELRELEASE
	APPEND root=/dev/sda1 rw
	INITRD ../initramfs_$KERNELRELEASE.img" >> /boot/syslinux/syslinux.cfg









