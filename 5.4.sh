cd $CLFS/sources

if [ ! -f linux-3.2.6.tar.bz2 ]
then
	wget http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.2.6.tar.bz2
fi

rm -rf linux-3.2.6
tar -jxf linux-3.2.6.tar.bz2
cd linux-3.2.6

install -dv /tools/include
make mrproper
make ARCH=mips headers_check
make ARCH=mips INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include


