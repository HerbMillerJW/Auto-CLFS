cd $CLFS/sources

if [ ! -f coreutils-8.15.tar.xz ]
then
	wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.15.tar.xz
fi

rm -rf coreutils-8.15
tar -Jxf coreutils-8.15.tar.xz
cd coreutils-8.15

touch man/uname.1 man/hostname.1

cat > config.cache << EOF
fu_cv_sys_stat_statfs2_bsize=yes
gl_cv_func_working_mkstemp=yes
EOF

./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --enable-install-program=hostname --cache-file=config.cache

make

make install

