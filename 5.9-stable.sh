cd $CLFS/sources

if [ ! -f mpfr-3.0.1.tar.bz2 ]
then
	wget http://www.mpfr.org/mpfr-3.0.1/mpfr-3.0.1.tar.bz2
fi

rm -rf mpfr-3.0.1
tar -jxf mpfr-3.0.1.tar.bz2
cd mpfr-3.0.1

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
./configure --prefix=/cross-tools \
    --enable-shared --with-gmp=/cross-tools

make

make install

