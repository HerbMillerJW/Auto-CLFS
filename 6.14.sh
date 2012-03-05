cd $CLFS/sources

if [ ! -f bzip2-1.0.6.tar.gz ]
then
	wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
fi

rm -rf bzip2-1.0.6
tar -zxf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6

cp -v Makefile{,.orig}
sed -e 's@^\(all:.*\) test@\1@g' Makefile.orig > Makefile

make CC="${CC}" AR="${AR}" RANLIB="${RANLIB}"

make PREFIX=/tools install

