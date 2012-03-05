cd $CLFS/sources

if [ ! -f binutils-2.22.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/binutils/binutils-2.22.tar.bz2
fi

rm -rf binutils-build binutils-2.22
tar -jxf binutils-2.22.tar.bz2
cd binutils-2.22

mkdir -v ../binutils-build
cd ../binutils-build

AR=ar AS=as ../binutils-2.22/configure \
  --prefix=/cross-tools --host=${CLFS_HOST} --target=${CLFS_TARGET} \
  --with-sysroot=${CLFS} --with-lib-path=/tools/lib --disable-nls --enable-shared \
  --disable-multilib --with-ppl=/cross-tools \
  --with-cloog=/cross-tools --enable-cloog-backend=isl

make configure-host
make

make install

cp -v ../binutils-2.22/include/libiberty.h /tools/include

