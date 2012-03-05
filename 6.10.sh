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

patch -Np1 -i ../gcc-4.6.2-specs-1.patch

patch -Np1 -i ../gcc-4.6.2-mips_fix-1.patch

echo -en '#undef STANDARD_INCLUDE_DIR\n#define STANDARD_INCLUDE_DIR "/tools/include/"\n\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h

cp -v gcc/Makefile.in{,.orig}
sed -e 's@\(^NATIVE_SYSTEM_HEADER_DIR =\).*@\1 /tools/include@g' \
    gcc/Makefile.in.orig > gcc/Makefile.in

mkdir -v ../gcc-build
cd ../gcc-build

../gcc-4.6.2/configure --prefix=/tools \
  --build=${CLFS_HOST} --host=${CLFS_TARGET} --target=${CLFS_TARGET} \
  --with-local-prefix=/tools --enable-long-long --enable-c99 \
  --enable-shared --enable-threads=posix --enable-__cxa_atexit \
  --disable-nls --enable-languages=c,c++ --disable-libstdcxx-pch \
  --disable-multilib --enable-cloog-backend=isl

cp -v Makefile{,.orig}
sed "/^HOST_\(GMP\|PPL\|CLOOG\)\(LIBS\|INC\)/s:-[IL]/\(lib\|include\)::" \
    Makefile.orig > Makefile

make AS_FOR_TARGET="${AS}" \
    LD_FOR_TARGET="${LD}"

make install

