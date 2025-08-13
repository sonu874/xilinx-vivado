#!/bin/bash
#############################################################
# Copyright (c) 1986-2014 Xilinx, Inc. All rights reserved.  #
#############################################################
 
#############################################################
# This script requires 3 arguments:
# 1-  Installation root
# 2-  Version
# 3- on/off 
# and will use the passed arguments to check the installation 
# paths for SDK and Vivado. if the installation path exists
# it will then run the webtalk_install.sh
#############################################################

if [ "$1" == "" ]; then
 echo "Installation root is missing."
 exit 1
fi
 
if [ "$2" == "" ]; then
 echo "Version (e.g. 2014.3 and etc) is missing"
 exit 1
fi

if [ "$3" == "" ]; then
 echo "on/off is missing."
 exit 1
fi

VIVADO="$1/Vivado/$2/data/webtalk"
if [ -d $VIVADO ]; then
#echo $VIVADO found 
$VIVADO/webtalk_install.sh $3
else
echo $VIVADO not found
fi



