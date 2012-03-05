cd $CLFS/sources

if [ ! -f m4-1.4.16.tar.bz2 ]
then
	wget http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.bz2
fi

rm -rf m4-1.4.16
tar -jxf m4-1.4.16.tar.bz2
cd m4-1.4.16

cat > config.cache << EOF
gl_cv_func_btowc_eof=yes
gl_cv_func_mbrtowc_incomplete_state=yes
gl_cv_func_mbrtowc_sanitycheck=yes
gl_cv_func_mbrtowc_null_arg=yes
gl_cv_func_mbrtowc_retval=yes
gl_cv_func_mbrtowc_nul_retval=yes
gl_cv_func_wcrtomb_retval=yes
gl_cv_func_wctob_works=yes
EOF

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --cache-file=config.cache

make

make install

