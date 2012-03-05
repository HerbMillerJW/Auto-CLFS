cd $CLFS/sources

if [ ! -f findutils-4.4.2.tar.gz ]
then
	wget http://ftp.gnu.org/gnu/findutils/findutils-4.4.2.tar.gz
fi

rm -rf findutils-4.4.2
tar -zxf findutils-4.4.2.tar.gz
cd findutils-4.4.2

echo "gl_cv_func_wcwidth_works=yes" > config.cache
echo "ac_cv_func_fnmatch_gnu=yes" >> config.cache

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --cache-file=config.cache

make

make install

