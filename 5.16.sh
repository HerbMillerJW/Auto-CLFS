cd $CLFS/sources

if [ ! -f gcc-4.6.2.tar.bz2 ]
then
	wget ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.6.2/gcc-4.6.2.tar.bz2
fi
if [ ! -f gcc-4.6.2-specs-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/gcc-4.6.2-specs-1.patch
fi
if [ ! -f gcc-4.6.2-mips_fix-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/gcc-4.6.2-mips_fix-1.patch
fi

rm -rf gcc-build gcc-4.6.2
tar -jxf gcc-4.6.2.tar.bz2
cd gcc-4.6.2

## Looks like this is incorrectly named or the wrong patch
# patch -Np1 -i ../gcc-4.6.2-pure64_specs-1.patch
patch -Np1 -i ../gcc-4.6.2-specs-1.patch

patch -Np1 -i ../gcc-4.6.2-mips_fix-1.patch

echo -en '#undef STANDARD_INCLUDE_DIR\n#define STANDARD_INCLUDE_DIR "/tools/include/"\n\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

cp -v gcc/Makefile.in{,.orig}
sed -e "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g" \
    gcc/Makefile.in.orig > gcc/Makefile.in

mkdir -v ../gcc-build
cd ../gcc-build

AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ../gcc-4.6.2/configure --prefix=/cross-tools \
  --build=${CLFS_HOST} --target=${CLFS_TARGET} --host=${CLFS_HOST} \
  --with-sysroot=${CLFS} --with-local-prefix=/tools --disable-nls \
  --enable-shared --enable-languages=c,c++ --enable-__cxa_atexit \
  --with-mpfr=/cross-tools --with-gmp=/cross-tools --enable-c99 \
  --with-ppl=/cross-tools --with-cloog=/cross-tools --enable-cloog-backend=isl \
  --enable-long-long --enable-threads=posix --disable-multilib

make AS_FOR_TARGET="${CLFS_TARGET}-as" \
    LD_FOR_TARGET="${CLFS_TARGET}-ld"

make install

