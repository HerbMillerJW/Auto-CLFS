cd $CLFS/sources

if [ ! -f ppl-0.11.2.tar.bz2 ]
then
	wget ftp://ftp.cs.unipr.it/pub/ppl/releases/0.11.2/ppl-0.11.2.tar.bz2
fi

rm -rf ppl-0.11.2
tar -jxf ppl-0.11.2.tar.bz2
cd ppl-0.11.2

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --enable-interfaces="c,cxx" --enable-shared --disable-optimization \
    --with-libgmp-prefix=/tools --with-libgmpxx-prefix=/tools

echo '#define PPL_GMP_SUPPORTS_EXCEPTIONS 1' >> confdefs.h

make

make install

