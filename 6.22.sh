cd $CLFS/sources

if [ ! -f grep-2.10.tar.xz ]
then
	wget http://ftp.gnu.org/gnu/grep/grep-2.10.tar.xz
fi

rm -rf grep-2.10
tar -Jxf grep-2.10.tar.xz
cd grep-2.10

cat > config.cache << EOF
ac_cv_func_malloc_0_nonnull=yes
ac_cv_func_realloc_0_nonnull=yes
EOF

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --disable-perl-regexp --without-included-regex \
    --cache-file=config.cache

make

make install

