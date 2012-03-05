cd $CLFS/sources

if [ ! -f linux-2.6.39.tar.bz2 ]
then
	wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.tar.bz2
fi

rm -rf linux-2.6.39
tar -jxf linux-2.6.39.tar.bz2
cd linux-2.6.39

install -dv /tools/include
make mrproper
make ARCH=mips headers_check
make ARCH=mips INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include


