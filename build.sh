#!/bin/bash
SCRIPT=$(realpath $0)
ORIG=$(dirname $SCRIPT)
DEST=$ORIG
cd $DEST
#apt-get source grub-pc
if [ -d $DEST/grub ]; then
    rm -rf $DEST/grub
fi
echo "Downloading grub source code..."
git clone git://git.savannah.gnu.org/grub.git
cd grub
echo "Building..."
./bootstrap
./linguas.sh
echo "es" > po/LINGUAS
./autogen.sh
# http://www.linuxfromscratch.org/lfs/view/development/chapter06/grub.html
./configure --prefix=/usr --sbindir=/sbin --sysconfdir=/etc --disable-efiemu --disable-werror && make
