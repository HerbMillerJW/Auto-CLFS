cd $CLFS/sources

if [ ! -f gmp-5.0.4.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/gmp/gmp-5.0.4.tar.bz2
fi

rm -rf gmp-5.0.4
tar -jxf gmp-5.0.4.tar.bz2
cd gmp-5.0.4

HOST_CC=gcc CPPFLAGS=-fexceptions ./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --enable-cxx

make

make install

