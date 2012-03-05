cd $CLFS/sources

if [ ! -f mpfr-3.1.0.tar.bz2 ]
then
	wget http://www.mpfr.org/mpfr-3.1.0/mpfr-3.1.0.tar.bz2
fi

rm -rf mpfr-3.1.0
tar -jxf mpfr-3.1.0.tar.bz2
cd mpfr-3.1.0

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --enable-shared --with-gmp=/tools

make

make install

