cd $CLFS/sources

if [ ! -f flex-2.5.35.tar.bz2 ]
then
	wget http://downloads.sourceforge.net/flex/flex-2.5.35.tar.bz2
fi
if [ ! -f flex-2.5.35-gcc44-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/flex-2.5.35-gcc44-1.patch
fi

rm -rf flex-2.5.35
tar -jxf flex-2.5.35.tar.bz2
cd flex-2.5.35

patch -Np1 -i ../flex-2.5.35-gcc44-1.patch

cat > config.cache << EOF
ac_cv_func_malloc_0_nonnull=yes
ac_cv_func_realloc_0_nonnull=yes
EOF

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --cache-file=config.cache

make

make install

