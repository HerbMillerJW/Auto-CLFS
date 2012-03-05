cd $CLFS/sources

if [ ! -f ncurses-5.9.tar.gz ]
then
	wget ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz
fi
if [ ! -f ncurses-5.9-bash_fix-1.patch ]
then
	wget http://patches.cross-lfs.org/dev/ncurses-5.9-bash_fix-1.patch
fi

rm -rf ncurses-5.9
tar -zxf ncurses-5.9.tar.gz
cd ncurses-5.9

patch -Np1 -i ../ncurses-5.9-bash_fix-1.patch

./configure --prefix=/cross-tools \
    --without-debug --without-shared

make -C include
make -C progs tic

install -v -m755 progs/tic /cross-tools/bin
