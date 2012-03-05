cd $CLFS/sources

if [ ! -f binutils-2.22.52.0.1.tar.xz ]
then
	wget http://www.kernel.org/pub/linux/devel/binutils/binutils-2.22.52.0.1.tar.xz
fi

rm -rf binutils-build binutils-2.22.52.0.1
tar -Jxf binutils-2.22.52.0.1.tar.xz
cd binutils-2.22.52.0.1

mkdir -v ../binutils-build
cd ../binutils-build

AR=ar AS=as ../binutils-2.22.52.0.1/configure \
  --prefix=/cross-tools --host=${CLFS_HOST} --target=${CLFS_TARGET} \
  --with-sysroot=${CLFS} --with-lib-path=/tools/lib --disable-nls --enable-shared \
  --enable-64-bit-bfd --disable-multilib

make configure-host
make

make install

cp -v ../binutils-2.21.1/include/libiberty.h /tools/include

