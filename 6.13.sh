cd $CLFS/sources

if [ ! -f bison-2.5.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/bison/bison-2.5.tar.bz2
fi

rm -rf bison-2.5
tar -jxf bison-2.5.tar.bz2
cd bison-2.5

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

