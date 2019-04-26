@echo off
:: birb bootloader v1.4
:: github webhook test
cls
title BirbTool
timeout 3 /nobreak > nul
echo Detecting PCI-E devices.....
if not exist .\fsetup.e goto fsetup
timeout 2 /nobreak > nul
echo birbTool v1.4
:brbldr
echo Boot options:
echo Use "shutdown" to shutdown birbTool.
echo Use "launch" to launch default BirbOS mode.
echo Use "usrtool" to start up the UserTool.
echo Use "dsktool" to check the birbOS installation.
echo Use "changepass" to change the password for your account.
echo Use "deluser" to delete your account.
echo See the BirbOS System version by using "checkver".
:ldr
title BirbTool
cd %0\..\
set ldr=
set/p "ldr=>"
if "%ldr%"=="shutdown" (cls && echo Shutting down the system, please wait... && timeout /t 5 /nobreak > nul && exit)
if "%ldr%"=="launch" (echo Booting from {3f79bb7-b435b05321-651daefd3}... && timeout /t 2 /nobreak > nul && start birbOS.cmd && exit)
if "%ldr%"=="usrtool" (echo Launching UserTool.... && timeout /t 3 /nobreak > nul && goto :start)
if "%ldr%"=="dsktool" (echo Launching dsktool.... && timeout /t 3 /nobreak > nul && goto check)
if "%ldr%"=="changepass" (echo Please wait... && timeout /t 3 /nobreak > nul && goto resetpass)
if "%ldr%"=="deluser" (echo Please wait... && timeout /t 3 /nobreak > nul && goto :deluser)
if "%ldr%"=="checkver" (echo Latest version of BirbOS is 8.3.1 && goto ldr)
if "%ldr%"=="about" (goto about)
if "%ldr%"=="" goto :ldr

echo Invalid choice.
goto :ldr

:usrtoool
cd users
echo birbOS UserTool
set /p "u=Enter username: "
if EXIST %u% goto exist
set /p c="Do you want to set a password? (Y/N): "
if %c%==N goto done
if %c%==n goto done
set /p p="Set password: "
md %u%
cd %u%
echo %p%>.birbuser
attrib +h .birbuser
cd ..
cd ..
echo Done!
pause
goto brbldr

:done
md %u%
cd ..
echo Done!
pause
goto :ldr

:exist
echo Sorry. This username is taken!
pause
goto :start

:resetpass
echo Please enter your username.
set /p "resetuser=Username:"
if "%resetuser%"=="" (echo You can't leave this field blank! && goto ldr)
if NOT exist users\%resetuser%\ goto :incorreset
if NOT exist users\%resetuser%\.birbuser goto :setnewpword
echo Type your old password.
set /p "oldpword=Password:"
set /p oldpassw=<users\%resetuser%\.birbuser
if NOT "%oldpword%"=="%oldpassw%" goto incorreset
:setnewpword
echo Type your new password. (Type "null" to delete your password.)
set /p "newpword=New password:"
if "%newpword%"=="null" (del /a /q .\users\%resetuser%\.birbuser && cd.. && cd.. && echo The user password was deleted. && goto ldr)
echo Retype to confirm:
set /p "newpassw=New password:"
if NOT "%newpassw%"=="%newpword%" goto incorreset
echo %newpword%>.\users\%resetuser%\.birbuser
echo Password successfully changed!
goto ldr

:incorreset
echo Incorrect credentials. Please try again.
goto ldr

:deluser
echo Type your account name and password.
set /p "deluser=Username:"
if "%deluser%"=="" goto incorreset
if NOT exist users\%deluser% goto incorreset
cd users\%deluser%
if NOT exist .\.birbuser goto confirmdel
set /p "delpword=Password:"
set /p delpassw=<.birbuser
if NOT "%delpword%"=="%delpassw%" goto :incorreset

:confirmdel
set /p "delacc=Are you sure you want to delete your account? (Y/N)"
if "%delacc%"=="n" goto ldr
if "%delacc%"=="N" goto ldr
if "%delacc%"=="y" goto delacc
if "%delacc%"=="Y" goto delacc
echo Invalid choice.
goto :confirmdel

:delacc
del /a /q .\*
cd ..
rd %deluser%
echo Your account was deleted successfully.
goto ldr

:check
if NOT EXIST apps echo "apps" folder not found! Please re-install birbOS or create it, and inside it create a folder called "temp"!
if NOT EXIST apps\temp echo "temp" folder not found! Please re-install birbOS or create it inside the "apps" folder!
if NOT EXIST BOOT.BLDR echo BOOT.BLDR not found! Please re-install it to boot up birbOS!
if NOT EXIST birbOS.cmd echo Main birbOS Module not found. reinstall to actually boot birbos up.
echo.
echo Please replace any missing files or folders!
echo If no errors appeared above you're fine!
goto ldr

:about
echo About birbTool:
echo Made by xAndrei166
echo Improved by Ad2017 and Dukemz
goto ldr

:fsetup
timeout 4 /nobreak > nul
echo Completing first time setup...
timeout 1 /nobreak > nul
echo "first-setup-complete" > fsetup.e
echo done.
echo press any key to continue to user creation.
pause > nul
goto usrtoool
