cd $CLFS/sources

if [ ! -f gettext-0.18.1.1.tar.gz ]
then
	wget http://ftp.gnu.org/gnu/gettext/gettext-0.18.1.1.tar.gz
fi

rm -rf gettext-0.18.1.1
tar -zxf gettext-0.18.1.1.tar.gz
cd gettext-0.18.1.1

cd gettext-tools

echo "gl_cv_func_wcwidth_works=yes" > config.cache

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --disable-shared --cache-file=config.cache

make -C gnulib-lib
make -C src msgfmt

cp -v src/msgfmt /tools/bin

