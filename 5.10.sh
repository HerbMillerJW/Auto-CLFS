cd $CLFS/sources

if [ ! -f mpc-0.9.tar.gz ]
then
	wget http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz
fi

rm -rf mpc-0.9
tar -zxf mpc-0.9.tar.gz
cd mpc-0.9

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
./configure --prefix=/cross-tools \
    --with-gmp=/cross-tools \
    --with-mpfr=/cross-tools

make

make install

