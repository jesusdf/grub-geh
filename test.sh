#!/bin/bash
SCRIPT=$(realpath $0)
ORIG=$(dirname $SCRIPT)
DEST=$ORIG
cd $DEST
if [ -d $DEST/grub ]; then
    cd $DEST/grub
    rm -f *.img
    ./grub-mkimage -p /boot -d grub-core -O i386-pc -o i386-pc.img at_keyboard configfile biosdisk ext2 linux test serial halt minicmd terminal cat rdmsr wrmsr &&
    ./grub-mkimage -p /boot -d grub-core -O i386-coreboot -o i386-coreboot.img at_keyboard configfile biosdisk ext2 linux test serial halt minicmd terminal cat rdmsr wrmsr
    #./grub-mkimage -p /boot -d grub-core -O i386-xen -o i386-xen.img &&
    #./grub-mkimage -p /boot -d grub-core -O i386-efi -o i386-efi.img &&
    #./grub-mkimage -p /boot -d grub-core -O x86_64-efi -o x86_64-efi.img
    ls -la *.img
    ( kvm --no-reboot -kernel $DEST/grub/i386-pc.img 1>/dev/null 2>&1 ) &
else
    echo "You have to build grub first..."
fi
