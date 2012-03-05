cd $CLFS/sources

if [ ! -f patch-2.6.1.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/patch/patch-2.6.1.tar.bz2
fi

rm -rf patch-2.6.1
tar -jxf patch-2.6.1.tar.bz2
cd patch-2.6.1

echo "ac_cv_func_strnlen_working=yes" > config.cache

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --cache-file=config.cache

make

make install

