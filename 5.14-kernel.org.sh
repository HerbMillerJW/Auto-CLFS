cd $CLFS/sources

if [ ! -f gcc-4.6.0.tar.bz2 ]
then
	wget ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.6.0/gcc-4.6.0.tar.bz2
fi
if [ ! -f gcc-4.6.0-specs-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/gcc-4.6.0-specs-1.patch
fi
if [ ! -f gcc-4.6.0-mips_fix-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/gcc-4.6.0-mips_fix-1.patch
fi
if [ ! -f gcc-4.6.0-branch_update-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/gcc-4.6.0-branch_update-1.patch
fi

rm -rf gcc-build gcc-4.6.0
tar -jxf gcc-4.6.0.tar.bz2
cd gcc-4.6.0

patch -Np1 -i ../gcc-4.6.0-branch_update-1.patch

## Looks like this is incorrectly named or the wrong patch
# patch -Np1 -i ../gcc-4.6.2-pure64_specs-1.patch
patch -Np1 -i ../gcc-4.6.0-specs-1.patch

patch -Np1 -i ../gcc-4.6.0-mips_fix-1.patch

echo -en '#undef STANDARD_INCLUDE_DIR\n#define STANDARD_INCLUDE_DIR "/tools/include/"\n\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

cp -v gcc/Makefile.in{,.orig}
sed -e "s@\(^CROSS_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g" \
    gcc/Makefile.in.orig > gcc/Makefile.in

touch /tools/include/limits.h

mkdir -v ../gcc-build
cd ../gcc-build

AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
  ../gcc-4.6.0/configure --prefix=/cross-tools \
  --build=${CLFS_HOST} --host=${CLFS_HOST} --target=${CLFS_TARGET} \
  --with-sysroot=${CLFS} --with-local-prefix=/tools --disable-nls \
  --disable-shared --with-mpfr=/cross-tools --with-gmp=/cross-tools \
  --with-ppl=/cross-tools --with-cloog=/cross-tools \
  --without-headers --with-newlib --disable-decimal-float \
  --disable-libgomp --disable-libmudflap --disable-libssp \
  --disable-threads --enable-languages=c --disable-multilib

make all-gcc all-target-libgcc

make install-gcc install-target-libgcc

