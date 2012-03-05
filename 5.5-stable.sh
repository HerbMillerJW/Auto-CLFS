cd $CLFS/sources

if [ ! -f file-5.07.tar.gz ]
then
	wget ftp://ftp.astron.com/pub/file/file-5.07.tar.gz
fi

rm -rf file-5.07
tar -zxf file-5.07.tar.gz
cd file-5.07

./configure --prefix=/cross-tools

make

make install

