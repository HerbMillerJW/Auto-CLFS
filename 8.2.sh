cd $CLFS/sources

if [ ! -f util-linux-2.20.tar.bz2 ]
then
	wget http://www.kernel.org/pub//linux/utils/util-linux/v2.20/util-linux-2.20.tar.bz2
fi

rm -rf util-linux-2.20
tar -jxf util-linux-2.20.tar.bz2
cd util-linux-2.20

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --disable-makeinstall-chown

make

make install

