cd $CLFS/sources

if [ ! -f file-5.10.tar.gz ]
then
	wget ftp://ftp.astron.com/pub/file/file-5.10.tar.gz
fi

rm -rf file-5.10
tar -zxf file-5.10.tar.gz
cd file-5.10

./configure --prefix=/cross-tools

make

make install

