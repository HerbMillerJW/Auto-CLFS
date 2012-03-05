cd $CLFS/sources

if [ ! -f bash-4.2.tar.gz ]
then
	wget http://ftp.gnu.org/gnu/bash/bash-4.2.tar.gz
fi
if [ ! -f bash-4.2.-branch_update-3.patch ]
then
	wget http://patches.cross-lfs.org/dev/bash-4.2-branch_update-3.patch
fi

rm -rf bash-4.2
tar -zxf bash-4.2.tar.gz
cd bash-4.2

patch -Np1 -i ../bash-4.2-branch_update-3.patch

cat > config.cache << "EOF"
ac_cv_func_mmap_fixed_mapped=yes
ac_cv_func_strcoll_works=yes
ac_cv_func_working_mktime=yes
bash_cv_func_sigsetjmp=present
bash_cv_getcwd_malloc=yes
bash_cv_job_control_missing=present
bash_cv_printf_a_format=yes
bash_cv_sys_named_pipes=present
bash_cv_ulimit_maxfds=yes
bash_cv_under_sys_siglist=yes
bash_cv_unusable_rtsigs=no
gt_cv_int_divbyzero_sigfpe=yes
EOF



./configure --prefix=/tools \
    --build=${CLFS_HOST} --host=${CLFS_TARGET} \
    --without-bash-malloc --cache-file=config.cache

make

make install

ln -sv bash /tools/bin/sh

