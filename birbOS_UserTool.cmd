@echo off
cd users
:start
title User tool V1.0.
set /p u="Enter username: "
if EXIST %u% goto exist
set /p c="Do you want to set a password? (Y/N): "
if %c%==N goto done
if %c%==n goto done
set /p p="Set password: "
md %u%
cd %u%
echo %p%>user.dll
attrib +h user.dll
echo Done!
pause
exit

:done
md %u%
echo Done!
pause
exit

:exist
echo Sorry. This username is taken!
pause
cls
goto start