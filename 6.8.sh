cd $CLFS/sources

if [ ! -f zlib-1.2.5.tar.bz2 ]
then
	wget http://zlib.net/zlib-1.2.5.tar.bz2
fi

rm -rf zlib-1.2.5
tar -jxf zlib-1.2.5.tar.bz2
cd zlib-1.2.5

./configure --prefix=/tools

make

make install

