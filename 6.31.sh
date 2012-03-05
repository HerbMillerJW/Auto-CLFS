cd $CLFS/sources

if [ ! -f xz-5.0.3.tar.bz2 ]
then
	wget http://tukaani.org/xz/xz-5.0.3.tar.bz2
fi

rm -rf xz-5.0.3
tar -jxf xz-5.0.3.tar.bz2
cd xz-5.0.3

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

