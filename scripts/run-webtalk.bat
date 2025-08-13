@ECHO OFF
REM #############################################################
REM # Copyright (c) 1986-2014 Xilinx, Inc. All rights reserved.  #
REM #############################################################
 
REM #############################################################
REM # This script requires 3 arguments:
REM # 1-  Installation root
REM # 2-  Version
REM # 3- on/off 
REM # and will use the passed arguments to check the installation 
REM # paths for SDK and Vivado. if the installation path exists
REM # it will then run the webtalk_install.sh
REM #############################################################



IF [%1] == [] (
echo "Installation root is missing."
GOTO missingParams
)
IF [%2] == [] (
echo "Version (e.g. 2014.3 and etc) is missing".
GOTO missingParams
)

IF [%3] == [] (
echo "on/off is missing."
GOTO missingParams
)

SET VIVADO=%1\Vivado\%2\data\webtalk
IF EXIST %VIVADO% (
REM echo "%VIVADO% found"
"%VIVADO%\webtalk_install.bat" %3
)

goto end

:missingParams
:end