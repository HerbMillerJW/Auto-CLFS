cd $CLFS/sources

if [ ! -f gzip-1.4.tar.gz ]
then
	wget http://ftp.gnu.org/gnu/gzip/gzip-1.4.tar.gz
fi

rm -rf gzip-1.4
tar -zxf gzip-1.4.tar.gz
cd gzip-1.4

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

