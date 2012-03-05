cd $CLFS/sources

if [ ! -f sed-4.2.1.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/sed/sed-4.2.1.tar.bz2
fi

rm -rf sed-4.2.1
tar -jxf sed-4.2.1.tar.bz2
cd sed-4.2.1

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

