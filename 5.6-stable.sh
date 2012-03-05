cd $CLFS/sources

if [ ! -f m4-1.4.16.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.bz2
fi

rm -rf m4-1.4.16
tar -jxf m4-1.4.16.tar.bz2
cd m4-1.4.16

./configure --prefix=/cross-tools

make

make install

