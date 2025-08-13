#!/bin/sh
install_path=$1
libcurses=""

if [ ! -e /etc/SuSE-release ]
then
	echo "Not running on SuSE, so nothing to do."
	exit 0
fi

if [ -e /lib64/libtinfo.so.5 ]
then
	echo "The libtinfo.so.5 library already exists at /lib64/libtinfo.so.5"
	exit 0
fi

if [ ! -e /lib64/libncurses.so.5 ]
then
	echo "/lib64/libncurses.so.5 doesn't exist, this library is required for Xilinx Software to function, please install with 'zypper install ncurses' then rerun the installer."
	exit 1
fi

libncurses=/lib64/`readlink /lib64/libncurses.so.5`
echo ${libncurses}

linkpath=${install_path}/lib/lnx64.o/libtinfo.so.5

echo "linking ncurses... ln -s ${libncurses} ${linkpath}"
ln -s ${libncurses} ${linkpath}

if [ $? -ne 0 ]
then
	echo "${linkpath} link creation failed!"
	exit 2
fi

exit 0