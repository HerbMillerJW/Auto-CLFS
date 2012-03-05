cd $CLFS/sources

if [ ! -f ppl-0.11.2.tar.bz2 ]
then
	wget ftp://ftp.cs.unipr.it/pub/ppl/releases/0.11.2/ppl-0.11.2.tar.bz2
fi

rm -rf ppl-0.11.2
tar -jxf ppl-0.11.2.tar.bz2
cd ppl-0.11.2

CPPFLAGS="-I/cross-tools/include" \
    LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
    ./configure --prefix=/cross-tools --enable-shared \
    --enable-interfaces="c,cxx" --disable-optimization \
    --with-libgmp-prefix=/cross-tools \
    --with-libgmpxx-prefix=/cross-tools

make

make install

