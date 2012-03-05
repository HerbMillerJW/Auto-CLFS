cd $CLFS/sources

if [ ! -f diffutils-3.2.tar.xz ]
then
	wget http://ftp.gnu.org/gnu/diffutils/diffutils-3.2.tar.xz
fi

rm -rf diffutils-3.2
tar -Jxf diffutils-3.2.tar.xz
cd diffutils-3.2

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

