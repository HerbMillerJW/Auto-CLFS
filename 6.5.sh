cd $CLFS/sources

if [ ! -f mpc-0.9.tar.gz ]
then
	wget http://www.multiprecision.org/mpc/download/mpc-0.9.tar.gz
fi

rm -rf mpc-0.9
tar -zxf mpc-0.9.tar.gz
cd mpc-0.9

EGREP="grep -E" ./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make

make install

