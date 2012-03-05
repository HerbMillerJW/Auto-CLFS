cd $CLFS/sources

if [ ! -f eglibc-2.13-r13356.tar.bz2 ]
then
	wget http://cross-lfs.org/files/packages/Final/eglibc-2.13-r13356.tar.bz2
fi
if [ ! -f eglibc--ports-2.13-r13356.tar.bz2 ]
then
	wget http://cross-lfs.org/files/packages/Final/eglibc-ports-2.13-r13356.tar.bz2
fi

rm -rf eglibc-build eglibc-2.15.r17386
tar -jxf eglibc-2.15.r17386.tar.bz2
cd eglibc-2.15.r17386

tar -jxvf ../eglibc-ports-2.13-r13356.tar.bz2
mv -v eglibc-ports-2.15-r13356 ports

cp -v Makeconfig{,.orig}
sed -e 's/-lgcc_eh//g' Makeconfig.orig > Makeconfig

mkdir -v ../eglibc-build
cd ../eglibc-build

cat > config.cache << "EOF"
libc_cv_forced_unwind=yes
libc_cv_c_cleanup=yes
libc_cv_gnu89_inline=yes
libc_cv_ssp=no
EOF

BUILD_CC="gcc" CC="${CLFS_TARGET}-gcc" \
    AR="${CLFS_TARGET}-ar" RANLIB="${CLFS_TARGET}-ranlib" \
    ../eglibc-2.15/configure --prefix=/tools \
    --host=${CLFS_TARGET} --build=${CLFS_HOST} \
    --disable-profile --enable-add-ons \
    --with-tls --enable-kernel=2.6.0 --with-__thread \
    --with-binutils=/cross-tools/bin --with-headers=/tools/include \
    --cache-file=config.cache

make

make install inst_vardbdir=/tools/var/db

