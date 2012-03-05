cd $CLFS/sources

if [ ! -f texinfo-4.13a.tar.gz ]
then
	wget http://ftp.gnu.org/gnu/texinfo/texinfo-4.13a.tar.gz
fi

rm -rf texinfo-4.13a
tar -zxf texinfo-4.13a.tar.gz
cd texinfo-4.13a

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET}

make -C tools/gnulib/lib
make -C tools
make

make install

