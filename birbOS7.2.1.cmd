@echo off
set "osbuild=birbOS Build 7.2.1"
title %osbuild%
:mainstage
cls
if NOT exist .\BIRBLDR.DLL (echo BIRBLDR.DLL is missing. && echo Press any key to restart && pause > nul && start .\BOOTLOADER.CMD && exit)
echo birbOS is booting.....
timeout /t 1 /nobreak > nul
:prompt
echo birbOS succesfully booted.
:logscreen
set/p "user=Username: "
if "%user%"=="" goto logon
if NOT EXIST users\%user% goto incor
if not exist users\%user%\user.dll goto logon 
set/p "pword=Password: "
find /c "%pword%" users\%user%\user.dll > nul
if %ERRORLEVEL%==0 goto logon
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
echo Enter command:

:prompt2

set "input="
set /p input="%user%@birbOS ~:"
if "%input%"=="owo" (echo uwu && goto prompt2)
if "%input%"=="birb" (echo BIIIIIIRB && goto prompt2)
if "%input%"=="calculate" (goto :calculating)
if "%input%"=="reboot" (echo Rebooting! && timeout 2 /nobreak > nul && start .\BOOTLOADER.CMD && exit)
if "%input%"=="shutdown" (timeout 2 /nobreak > nul && goto shutdown)
if "%input%"=="grab-sourcecode" (echo Save output to: (full path) && set /p chco= && copy %appdata%\birbos5.cmd %chco% && goto prompt2)
if "%input%"=="help" (echo Commands are: help, owo, birb, calculate, reboot, shutdown, grab-sourcecode, stfu, guess-game, clear, changelog, about, logoff && goto :prompt2 )
if "%input%"=="stfu" (echo no u && goto :prompt2)
if "%input%"=="guess-game" (echo Starting! && goto :gueeees)
if "%input%"=="clear" (cls && goto :prompt2)
if "%input%"=="about" (echo %osbuild% - Developed by xandrei, Dukemz and Ad2017. && goto :prompt2)
if "%input%"=="" (goto :prompt2)
if "%input%"=="changelog" (cls && type .\changelog.txt && echo. && goto :prompt2)
if EXIST "%input%.cmd" goto verif
if "%input%"=="logoff" goto logoff
if "%input%"=="folder" goto folder
if "%input%"=="writedoc" goto write
if "%input%"=="readdoc" goto read
if "%input%"=="runapp" goto runapp


goto :shutdownerr

:incor
cls
color cf
title U BWOKE A EULE
echo Incorrect credentials. You are not a birb.
echo Press any key to try again.
pause > nul
color 07
title %osbuild%
goto prompt

:shutdown
cls
echo birbOS is shutting down...
timeout /t 3 /nobreak > nul
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
echo Command not implemented! If you wanted to run a file, be sure its .CMD and you put the name correctly!
goto prompt2

:gueeees
title Guessing Game
echo Wait while we generate your secret number.
:qset
set "varr=%random%"
if %varr% GTR 30000 goto qset
if %varr% LSS 10000 goto qset 
:game
echo Guess my number! (hint: it's between 30000 and 10000)
set /p "num=>"
:game2
echo %num%| findstr /r "^[1-9][0-9]*$">nul
if %ERRORLEVEL%==1 goto reguess
if %ERRORLEVEL%==2 goto reguess
if /i %num% GTR %varr% (echo Lower! && goto reguess)
if /i %num% LSS %varr% (echo Higher! && goto reguess)
if /i %num%==BIRB (echo You're a birb, eh? The answer is %varr% && goto :game2)
if /i %num%==exit (echo Exiting... && title %osbuild%)


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
if "%user%"=="" echo Sorry. As a guest you can't run files thru BirbOS. && goto prompt2
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
goto logscreen
echo Unexpected Error.
pause
exit

:folder
if "%user%"=="" echo Guests can't create folders. && goto prompt2
set /p fname="Enter folder name: "
cd users\%user%
md %fname%
cd..
cd..
goto prompt2

:write
if "%user%"=="" echo Guests can't create documents. && goto prompt2
cd users\%user%
set /p docName="Enter document name : "
set /p private="Make file private? (Y/N) : "
echo.> %docName%.txt
if %private%==Y echo %docName%.txt>>privatedocs.binfo
echo Type "exit.." to exit. Press enter to add new line.
cls
:type
set /p textLine="::"
if "%textLine%"=="exit" cd.. && cd.. && goto prompt2
echo.%textLine%>> %docName%.txt
set textLine=
goto type

:read
if "%user%"=="" echo Guests can't read files && goto prompt2
set /p userread="Which user's doc. you want to read? : "
if NOT EXIST users\%userread% echo User not found! goto prompt2
set /p docread="What document do you want to read? (no .txt) : "
if NOT EXIST users\%userread% echo Document not found! goto prompt2
findstr "%docread%.txt" users\%userread%\privatedocs.binfo > nul
if %ERRORLEVEL%==0 if NOT "%userread%"=="%user%" echo Sorry. This file is private. && goto prompt2
echo Reading users\%userread%\%docread%.txt :
echo.
echo.
echo.
echo -----start of document
type users\%userread%\%docread%.txt
echo.
echo.
echo.
echo -----end of document
echo Press any key to exit reader.
pause > nul
goto prompt2

:runapp
if "%user%"=="" echo Guests can't run apps && goto prompt2
set /p appti="Enter app name (without .birbapp) : "
cd apps
if NOT EXIST %appti%.birbapp echo App not found && goto prompt2
copy %appti%.birbapp temp
set temp=%random%
rename temp\%appti%.birbapp temp_app%temp%.bat
start temp\temp_app%temp%.bat
cd..
cd..
goto prompt2

