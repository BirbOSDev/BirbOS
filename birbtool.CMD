@echo off
rem birb bootloader v0.0.1
rem github webhook test
cls
title BirbTool (recovery for birbOS)
timeout 4 /nobreak > nul
echo Detecting PCI-E devices.....
timeout 1 /nobreak > nul
echo birbTool v1.0
:brbldr
title BirbTool
echo Boot options:
echo Use "shutdown" to shutdown birbTool.
echo Use "launch" to launch default BirbOS mode.
echo Use "CDR" to launch the CD-ROM file (.\CD-ROM.CMD).
echo Use "usrtool" to start up the UserTool.
echo Use "dsktool" to check the birbOS installation
:ldr
set/p "ldr=>"
if "%ldr%"=="shutdown" (cls && echo Shutting down the system, please wait... && timeout /t 5 /nobreak > nul && exit)
if "%ldr%"=="launch" (echo Booting from {3f79bb7-b435b05321-651daefd3}... && timeout /t 2 /nobreak > nul && start .\birbOS.cmd && exit)
if "%ldr%"=="cdr" (echo Booting from CD-ROM... && timeout /t 2 /nobreak > nul && start .\CD-ROM.CMD && exit)
if "%ldr%"=="usrtool" (echo Launching UserTool.... && timeout /t 3 /nobreak > nul && goto :start)
if "%ldr%"=="dsktool" (echo Launching dsktool.... && timeout /t 3 /nobreak > nul && goto check)



echo Invalid choice.
goto :ldr

:birbtool
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
certutil -encode '%p%' tmp.b64 && findstr /v /c:- tmp.b64 > data.b64
echo %p%>.birbuser
attrib +h .birbuser
echo Done!
pause
exit

:done
md %u%
echo Done!
pause
goto

:exist
echo Sorry. This username is taken!
pause


:check

if NOT EXIST sys_apps echo sys_apps folder and its apps not found! Please re-install birbOS!
if NOT EXIST sys_apps\bsod.birbapp echo bsod.birbapp not found! Please re-install birbOS!
if NOT EXIST apps echo apps folder not found! Please re-install birbOS or create it, and inside it create a folder called "temp"!
if NOT EXIST apps\temp echo temp folder not found! Please re-install birbOS or create it inside the "apps" folder!
if NOT EXIST BOOTLOADER.CMD echo BOOTLOADER.CMD not found! Please re-install birbOS!
if NOT EXIST birbOS_UserTool.cmd echo birbOS_UserTool.cmd not found! Please re-install birbOS!
if NOT EXIST CD-ROM.CMD echo CD-ROM.CMD not found! It's not a must but its recomended to have it installed!
echo.
echo Please replace any missing files or folders!
echo.
echo If no errors appeared you're fine!

:goto ldr