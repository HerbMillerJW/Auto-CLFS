cd $CLFS/sources

if [ ! -f make-3.82.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/make/make-3.82.tar.bz2
fi

rm -rf make-3.82
tar -jxf make-3.82.tar.bz2
cd make-3.82

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

