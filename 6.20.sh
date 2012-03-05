cd $CLFS/sources

if [ ! -f gawk-4.0.0.tar.xz ]
then
	wget http://ftp.gnu.org/gnu/gawk/gawk-4.0.0.tar.xz
fi

rm -rf gawk-4.0.0
tar -Jxf gawk-4.0.0.tar.xz
cd gawk-4.0.0

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

