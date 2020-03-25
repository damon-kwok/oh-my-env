@echo off

set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem /cygdrive/d/
rem --socket-name
rem --server-file
rem --no-wait
rem --create-frame
rem --alternate-editor

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set args=%1
shift /0

:loop
set arg=%1
if "%arg%"=="" (goto end)
set args=%args% %arg%
shift /0
goto loop

:end
if "%args%"=="" (goto eof)

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem D:\\msys64\\bin\\cygpath.exe %1% > emacs-open-info.log
rem set /P result=<emacs-open-info.log
rem del emacs-open-info.log

rem for /F %%i in ('D:\\msys64\\bin\\cygpath.exe %1%') do ( set result=%%i)
rem for /f "delims=" %%t in ('D:\\msys64\\bin\\cygpath.exe %1%') do set result=%%t
rem echo "open: %result%"

rem %%%%%%%%%%%%%%%%%%%%%%%%
rem set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%
rem D:\\msys64\\usr\\bin\\bash -c "em \"%1%\""

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

echo open:%args%
bash -c "emacsclient --no-wait --server-file='/tmp/emacstty1000/server' --alternate-editor='emacs -Q -nw' \"`cygpath \"%args%\"`\""
rem bash -c "emacsclient --no-wait --server-file='/tmp/emacstty1000/server' --alternate-editor='emacs -Q -nw' \"%args%\""

:eof
