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

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --with-gmp-prefix=/tools

make

make install

