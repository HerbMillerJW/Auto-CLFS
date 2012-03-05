cd $CLFS/sources

if [ ! -f gmp-5.0.4.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/gmp/gmp-5.0.4.tar.bz2
fi

rm -rf gmp-5.0.4
tar -Jxf gmp-5.0.4.tar.bz2
cd gmp-5.0.4

CPPFLAGS=-fexceptions ./configure \
    --prefix=/cross-tools --enable-cxx

make

make install

