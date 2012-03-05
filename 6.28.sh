cd $CLFS/sources

if [ ! -f tar-1.26.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/tar/tar-1.26.tar.bz2
fi

rm -rf tar-1.26
tar -jxf tar-1.26.tar.bz2
cd tar-1.26

cat > config.cache << EOF
gl_cv_func_wcwidth_works=yes
gl_cv_func_btowc_eof=yes
ac_cv_func_malloc_0_nonnull=yes
ac_cv_func_realloc_0_nonnull=yes
gl_cv_func_mbrtowc_incomplete_state=yes
gl_cv_func_mbrtowc_nul_retval=yes
gl_cv_func_mbrtowc_null_arg=yes
gl_cv_func_mbrtowc_retval=yes
gl_cv_func_wcrtomb_retval=yes
EOF

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --cache-file=config.cache

make

make install

