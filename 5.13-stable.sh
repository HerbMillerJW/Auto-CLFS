cd $CLFS/sources

if [ ! -f binutils-2.21.1a.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/binutils/binutils-2.21.1a.tar.bz2
fi

rm -rf binutils-build binutils-2.21.1
tar -jxf binutils-2.21.1a.tar.bz2
cd binutils-2.21.1

mkdir -v ../binutils-build
cd ../binutils-build

AR=ar AS=as ../binutils-2.21.1/configure \
  --prefix=/cross-tools --host=${CLFS_HOST} --target=${CLFS_TARGET} \
  --with-sysroot=${CLFS} --with-lib-path=/tools/lib --disable-nls --enable-shared \
  --disable-multilib

make configure-host
make

make install

cp -v ../binutils-2.21.1/include/libiberty.h /tools/include

