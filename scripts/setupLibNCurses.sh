#!/bin/sh
install_path=$1
libcurses=""

libncurses=/lib64/libncurses.so.6
echo ${libncurses}

linkpath=${install_path}/lib/lnx64.o/SuSE/libncurses.so.5

echo "linking ncurses... ln -s ${libncurses} ${linkpath}"
ln -s ${libncurses} ${linkpath}

exit 0