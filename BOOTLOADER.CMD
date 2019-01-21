@echo off
rem birb bootloader v0.0.1
rem github webhook test
cls
title birbOS Bootloader v0.0.1
timeout 4 /nobreak > nul
echo Detecting PCI-E devices.....
timeout 1 /nobreak > nul

echo Boot options:
echo 0: Shutdown
echo 1: Boot from HDD (birbOS Boot Manager)
echo 2: Boot from CD-ROM (.\CD-ROM.CMD)
echo To see system info use "sysnand"
:ldr
set/p "ldr=>"
if "%ldr%"=="0" (cls && echo Shutting down the system, please wait... && timeout /t 5 /nobreak > nul && exit)
if "%ldr%"=="1" (echo Booting from {3f79bb7-b435b05321-651daefd3}... && timeout /t 2 /nobreak > nul && start .\birbOS7.1.cmd && exit)
if "%ldr%"=="2" (echo Booting from CD-ROM... && timeout /t 2 /nobreak > nul && start .\CD-ROM.CMD && exit)
if "%ldr%"=="sysnand" (goto sysmenu)


echo Invalid choice.
goto :ldr

:sysmenu
ver
echo.Operating System Type: %OS% / BirbOS Loader 0.0.1
echo.Processor Architecture: %PROCESSOR_ARCHITECTURE%
echo.Processor Architecture (x64): %PROCESSOR_ARCHITEW6432%
echo.Processor ID: %PROCESSOR_IDENTIFIER%
echo.Processor Level: %PROCESSOR_LEVEL%
echo.Processor Revision: %PROCESSOR_REVISION%
echo.Number of Processors: %NUMBER_OF_PROCESSORS%
echo.Windows Location: %windir%
echo.User Domain: %USERDOMAIN%
echo.Highest NUMA Node Number for this computer: %HighestNumaNodeNumber%
echo.User Location: %COMPUTERNAME%\%USERNAME% / %HOMEDRIVE%%HOMEPATH%
goto ldr

rem test