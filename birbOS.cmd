@echo off
:SYSTEMSTARTUP
set "osbuild=birbOS Build 8.2"
title %osbuild%
timeout /t 2 /nobreak > nul
:mainstage
set setthm=<theme.txt
cls
cd %~dp0
if NOT exist .\BOOT.FIRM (echo BOOTROM FAILED && ECHO ERRCODE: 000FFF01 00000000 00000011 && echo PRESS ANY KEY TO SHUTDOWN && pause > nul && exit)
echo birbOS is booting.....
timeout /t 3 /nobreak > nul
echo birbOS successfully booted.
:prompt
set col=
set bcol=
echo Login to birbOS. (Type "Guest" for guest account, and type "shutdown" to shutdown.)
set user=
set passw=
set pword=
if EXIST .\apps\temp\birbuser.tmp del /q .\apps\temp\birbuser.tmp
cd users
echo.
echo List of available users:
dir /b
echo Guest
cd ..
echo.
set /p "user=Username:" 
if "%user%"=="" goto incor
if "%user%"=="Guest" goto logon
if "%user%"=="guest" goto logon
if "%user%"=="shutdown" goto shutdown
if NOT EXIST users\%user%\ goto incor
if NOT exist users\%user%\.birbuser goto logon
set /p passw=<users\%user%\.birbuser
set /p "pword=Password:"
if "%passw%"=="%pword%" goto logon
goto incor
:logon
echo Login successful.
echo.
echo.
echo       °°°°      °     °°°°°°      °°°°       °°°°      °°°°°
echo       °   °           °     °     °   °     °    °    °
echo       °    °    °     °     °     °    °    °    °   °
echo       °°°°°     °     °°°°°°°     °°°°°     °    °   °°°°°°°
echo       °    °    °     °°          °    °    °    °         °
echo       °   °     °     °  °        °   °     °    °        °
echo       °°°°      °     °   °°      °°°°       °°°°    °°°°°
echo.
echo.
color 1a
timeout /t 1 /nobreak > nul
color 2b
timeout /t 1 /nobreak > nul
color 3c
timeout /t 1 /nobreak > nul
color 0F
echo Welcome, %user%!
timeout /t 1 /nobreak > nul
echo %user% > .\apps\temp\birbuser.tmp
echo Enter command:

:prompt2
cd %0\..\
set /p setthm=<theme.birbtheme
color %setthm%
set "input="
set /p input="%user%@birbOS ~:"
if "%input%"=="owo" (echo uwu && goto prompt2)
if "%input%"=="uwu" (echo owo && goto prompt2)
if "%input%"=="birb" (echo BIIIIIIRB && goto prompt2)
if "%input%"=="calculate" (goto :calculating)
if "%input%"=="reboot /rec" (echo Rebooting! && timeout /t 3 /nobreak > nul && start .\birbtool.CMD && exit)
if "%input%"=="reboot" (echo Rebooting birbOS. && timeout /t 3 /nobreak > nul && cls && color 07 && goto :SYSTEMSTARTUP)
if "%input%"=="shutdown" (timeout 2 /nobreak > nul && goto shutdown)
if "%input%"=="help" (echo Commands are: help, owo, uwu, birb, calculate, reboot [/rec], shutdown [/f], stfu, guess-game, clear, changelog, about, logoff, runapp, writedoc, readdoc, folder, clean, download-update, install-update, set-theme. && goto :prompt2 )
if "%input%"=="stfu" (echo no u && goto :prompt2)
if "%input%"=="guess-game" (echo Starting! && goto :gueeees)
if "%input%"=="clear" (cls && goto :prompt2)
if "%input%"=="about" (echo %osbuild% - Developed by xandrei, Dukemz and Ad2017. && goto :prompt2)
if "%input%"=="" (goto :prompt2)
if "%input%"=="changelog" (cls && type .\changelog.txt && echo. && goto :prompt2)
if "%input%"=="logoff" goto logoff
if "%input%"=="folder" goto folder
if "%input%"=="writedoc" goto write
if "%input%"=="readdoc" goto read
if "%input%"=="runapp" goto runapp
if "%input%"=="clean" goto clean
if "%input%"=="shutdown /f" exit
if "%input%"=="download-update" goto update
if "%input%"=="set-theme" goto theme
if EXIST apps\games\%input%\%input%.birbgame goto :launchgame
goto :shutdownerr

:incor
cls
color cf
title U BWOKE A EULE
echo Incorrect credentials.
echo Press any key to try again.
pause > nul
color 07
title %osbuild%
cls
goto prompt

:shutdown
cls
echo birbOS is shutting down...
timeout /t 3 /nobreak > nul
if EXIST .\apps\temp\birbuser.tmp del /q .\apps\temp\birbuser.tmp
exit


:calculating
echo The calculator is in an early stage. You may experience crashes and bugs. Have fun!
echo Type exit to go to the prompt
set/p t1=First number:
if %t1%== exit (goto prompt2)
set/p t2=Second number:
set/p equ=Equation: (+,-,*,/)
set/a answer=%t1% %equ% %t2%
echo %answer%
goto prompt2

:shutdownerr
echo Command not implemented!
goto prompt2

:gueeees
title Guessing Game
echo Wait while we generate your secret number.
:qset
set "varr"="%random%"
if %varr% GTR 30000 goto qset
if %varr% LSS 10000 goto qset 
:game
echo Guess my number! (hint: it's between 30000 and 10000)
set /p "num=>"
:game2
echo %num%| findstr /r "exit">nul
if %ERRORLEVEL%==0 goto skip2223
echo %num%| findstr /r "birb">nul
if %ERRORLEVEL%==0 goto skip2223
echo %num%| findstr /r "^[1-9][0-9]*$">nul
if %ERRORLEVEL%==1 goto reguess
if %ERRORLEVEL%==2 goto reguess
:skip2223
if "%num%"=="birb" (echo The answer is %varr% && goto :reguess)
if "%num%"=="exit" (echo Exiting... && title %osbuild% && goto :prompt2)
if /i %num% GTR %varr% (echo Lower! && goto reguess)
if /i %num% LSS %varr% (echo Higher! && goto reguess)


:win
echo Congratulations! You won! 
echo Press any key to exit!
pause > nul
goto prompt2
:reguess
set /p "num=>"
goto game2

:verif
if NOT "%user%"=="" start %input%.cmd && goto prompt2
if "%user%"=="Guest" (echo Sorry. As a guest you can't run files through BirbOS. && goto prompt2)
echo Unexpected Error
pause
exit

:logoff
cls
timeout /t 1 /nobreak > nul
echo Logging off.
timeout /t 2 /nobreak > nul
cls
echo Logging off..
timeout /t 2 /nobreak > nul
cls
echo Logging off...
cls
timeout /t 3 /nobreak > nul
color 07
goto prompt
echo Unexpected Error.
pause
goto prompt2

:folder
if "%user%"=="Guest" echo Sorry, guests can't create folders. && goto prompt2
set /p "fname2=Enter folder name: "
cd users\%user%
md %fname%
cd..
cd..
goto prompt2

:write
if "%user%"=="Guest" echo Guests can't create documents. && goto prompt2
cd users\%user%
set /p docName="Enter document name : "
if exist %docName%.bdoc echo Document exists. && goto write
set /p private="Make file private? (Y/N) : "
echo.>%docName%.bdoc
if %private%==Y echo %docName%.bdoc>>privatedocs.binfo
echo Type "exit.." to exit. Press enter to add new line.
cls
:type
set /p textLine="::"
if "%textLine%"=="exit" cd.. && cd.. && goto prompt2
echo.%textLine%>>%docName%.doc
set textLine=
goto type

:read
if "%user%"=="Guest" echo Guests can't read files. && goto prompt2
set /p userread="Which user's document you want to read? : "
if NOT EXIST users\%userread% echo User not found! && goto prompt2
set /p docread="What document do you want to read? (no .doc) : "
if NOT EXIST users\%userread%\%docread%.bdoc echo Document not found! && goto prompt2
findstr "%docread%.bdoc" users\%userread%\privatedocs.binfo > nul
if %ERRORLEVEL%==0 if NOT "%userread%"=="%user%" (echo Sorry. This file is private. && goto prompt2)
echo Reading users\%userread%\%docread%.bdoc :
echo.
type users\%userread%\%docread%.bdoc
echo.
echo Press any key to exit reader.
pause > nul
goto prompt2

:runapp
if "%user%"=="Guest" echo Guests can't run apps. && goto prompt2
set /p appti="Enter app name (without .birbapp) : "
cd apps
if NOT EXIST %appti%.birbapp (echo App not found. && cd .. && goto prompt2)
copy %appti%.birbapp temp
set temp=%random%
rename temp\%appti%.birbapp temp_app%temp%.bat
attrib +h temp\temp_app%temp%.bat
start temp\temp_app%temp%.bat
cd..
echo After closing the app, use "clean" to get rid of temp files!
goto prompt2

:clean
cd apps\temp
for %%i in (*) do del %%i
echo %user% > birbuser.tmp
echo Cleaned!
cd..
cd..
goto prompt2

:update
if "%user%"=="Guest" (echo Sorry, the Guest account cannot use the update system. && goto prompt2)
cls
echo Connecting to the BirbOS server on DriveHQ...
timeout /t 3 /nobreak > nul
echo When the prompt appears, logon with the username "BirbOSDevs" and use the password "BirbOS6767".
echo Download latest version using "get birbos.zip"
echo Come here and download any files needed. They will save as .zip in upload_files.
echo Quit the FTP prompt at any time by typing "quit".
pause
echo.
cd upload_files
ftp ftp.drivehq.com
echo FTP connection closed.
goto prompt2
rem easter egg

:theme
if "%user%"=="Guest" echo Sorry, Guests can't set themes. && goto prompt2
echo Themes : 'dark', 'light-dark', 'light', 'hacker', 'error', 'bsod'.
echo For custom themes, use 'custom'.
echo.
set /p theme="Theme : "
if "%theme%"=="dark" (
echo f>theme.birbtheme
set /p setthm=<theme.birbtheme
color %setthm%
echo.
goto prompt2
)
if "%theme%"=="light-dark" (
echo 8f>theme.birbtheme
set /p setthm=<theme.birbtheme
color %setthm%
goto prompt2
)
if "%theme%"=="light" (
echo f0>theme.birbtheme
set /p setthm=<theme.birbtheme
color %setthm%
goto prompt2
)
if "%theme%"=="hacker" (
echo a>theme.birbtheme
set /p setthm=<theme.birbtheme
color %setthm%
goto prompt2
)
if "%theme%"=="error" (
echo c>theme.birbtheme
set /p setthm=<theme.birbtheme
color %setthm%
goto prompt2
)
if "%theme%"=="bsod" (
echo 1f>theme.birbtheme
set /p setthm=<theme.birbtheme
color %setthm%
goto prompt2
)
if "%theme%"=="custom" (
goto customthm
)
echo.
echo Unknown theme.
echo.
goto theme

:customthm
echo Colors :
echo 0 - black
echo 1 - blue
echo 2 - green
echo 3 - aqua
echo 4 - red
echo 5 - purple
echo 6 - yellow
echo 7 - light gray
echo 8 - gray
echo f - white
echo.
:setcustomthm
set /p tcl="Text color : "
if "%tcl%"=="a" echo Not a color. && goto setcustomthm
if "%tcl%"=="A" echo Not a color. && goto setcustomthm
if "%tcl%"=="B" echo Not a color. && goto setcustomthm
if "%tcl%"=="b" echo Not a color. && goto setcustomthm
if "%tcl%"=="C" echo Not a color. && goto setcustomthm
if "%tcl%"=="c" echo Not a color. && goto setcustomthm
if "%tcl%"=="D" echo Not a color. && goto setcustomthm
if "%tcl%"=="d" echo Not a color. && goto setcustomthm
if "%tcl%"=="E" echo Not a color. && goto setcustomthm
if "%tcl%"=="e" echo Not a color. && goto setcustomthm
for %%i in (1 2 3 4 5 6 7 8 f) do if not %tcl%==%%i echo Not a color. && goto setcustomthm
set /p bgcl="BG color : "
if "%bgcl%"=="a" echo Not a color. && goto setcustomthm
if "%bgcl%"=="A" echo Not a color. && goto setcustomthm
if "%bgcl%"=="B" echo Not a color. && goto setcustomthm
if "%bgcl%"=="b" echo Not a color. && goto setcustomthm
if "%bgcl%"=="C" echo Not a color. && goto setcustomthm
if "%bgcl%"=="c" echo Not a color. && goto setcustomthm
if "%bgcl%"=="D" echo Not a color. && goto setcustomthm
if "%bgcl%"=="d" echo Not a color. && goto setcustomthm
if "%bgcl%"=="E" echo Not a color. && goto setcustomthm
if "%bgcl%"=="e" echo Not a color. && goto setcustomthm
for %%i in (1 2 3 4 5 6 7 8 f) do if not %bgcl%==%%i echo Not a color. && goto setcustomthm
echo %bgcl%%tcl%>theme.birbtheme
set /p setthm=<theme.birbtheme
goto prompt2




