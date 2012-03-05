cd $CLFS/sources

if [ ! -f cloog-ppl-0.15.11.tar.gz ]
then
	wget ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-ppl-0.15.11.tar.gz
fi

rm -rf cloog-ppl-0.15.11
tar -zxf cloog-ppl-0.15.11.tar.gz
cd cloog-ppl-0.15.11

cp -v configure{,.orig}
sed -e "/LD_LIBRARY_PATH=/d" \
    configure.orig > configure

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
    ./configure --prefix=/cross-tools --enable-shared --with-bits=gmp \
    --with-gmp=/cross-tools --with-ppl=/cross-tools

make

make install

