@echo off
cls
title birbOS Bootloader v0.0.1
timeout 4 /nobreak > nul
echo Detecting PCI-E devices.....
timeout 1 /nobreak > nul

echo Boot options:
echo 0: Shutdown
echo 1: Boot from HDD (birbOS Boot Manager)
echo 2: Boot from CD-ROM (.\CD-ROM.CMD)
:ldr
set/p "ldr=>"
if "%ldr%"=="0" (cls && echo Shutting down the system, please wait... && timeout /t 5 /nobreak > nul && exit)
if "%ldr%"=="1" (echo Booting from {3f79bb7-b435b05321-651daefd3}... && timeout /t 2 /nobreak > nul && start .\birbOS7.2.2.cmd && exit)
if "%ldr%"=="2" (echo Booting from CD-ROM... && timeout /t 2 /nobreak > nul && start .\CD-ROM.CMD && exit)

echo Invalid choice.
goto :ldr
