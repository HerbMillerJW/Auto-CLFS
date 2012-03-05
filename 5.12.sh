cd $CLFS/sources

if [ ! -f cloog-0.16.3.tar.gz ]
then
	wget http://www.bastoul.net/cloog/pages/download/cloog-0.16.3.tar.gz
fi

rm -rf cloog-0.16.3
tar -zxf cloog-0.16.3.tar.gz
cd cloog-0.16.3

cp -v configure{,.orig}
sed -e "/LD_LIBRARY_PATH=/d" \
    configure.orig > configure

LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
    ./configure --prefix=/cross-tools --enable-shared \
    --with-gmp-prefix=/cross-tools

make

make install

