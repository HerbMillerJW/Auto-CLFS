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

../binutils-2.22.52.0.1/configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} --target=${CLFS_TARGET} \
    --with-lib-path=/tools/lib --disable-nls --enable-shared \
    --disable-multilib --with-cloog=/tools \
    --with-ppl=/tools --enable-cloog-backend=isl

make configure-host
make

make install

