mkdir -pv ${CLFS}/{dev,proc,sys}

mount -vt proc proc ${CLFS}/proc
mount -vt sysfs sysfs ${CLFS}/sys

mknod -m 600 ${CLFS}/dev/console c 5 1
mknod -m 666 ${CLFS}/dev/null c 1 3

mount -v -o bind /dev ${CLFS}/dev

mount -f -vt tmpfs tmpfs ${CLFS}/dev/shm
mount -f -vt devpts -o gid=4,mode=620 devpts ${CLFS}/dev/pts

