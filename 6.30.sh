cd $CLFS/sources

if [ ! -f vim-7.3.tar.bz2 ]
then
	wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
fi
if [ ! -f vim-7.3-branch_update-3.patch ]
then
	wget http://patches.cross-lfs.org/dev/vim-7.3-branch_update-3.patch
fi

rm -rf vim-7.3
tar -jxf vim-7.3.tar.bz2
cd vim-7.3

patch -Np1 -i ../vim-7.3-branch_update-3.patch

sed -i "/using uint32_t/s/as_fn_error/#&/" src/auto/configure

cat > src/auto/config.cache << "EOF"
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
ac_cv_sizeof_int=4
ac_cv_sizeof_long=4
ac_cv_sizeof_time_t=4
ac_cv_sizeof_off_t=4
EOF

echo '#define SYS_VIMRC_FILE "/tools/etc/vimrc"' >> src/feature.h

./configure \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --prefix=/tools --enable-multibyte --enable-gui=no \
    --disable-gtktest --disable-xim --with-features=normal \
    --disable-gpm --without-x --disable-netbeans \
    --with-tlib=ncurses

make

make install

ln -sv vim /tools/bin/vi

cat > /tools/etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2
set ruler
syntax on

" End /etc/vimrc
EOF

