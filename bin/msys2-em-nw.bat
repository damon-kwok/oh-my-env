@echo off
echo %1%
rem /cygdrive/d/
rem D:\\msys64\\bin\\cygpath.exe %1% > emacs-open-info.log
rem set /P result=<emacs-open-info.log
rem del emacs-open-info.log

rem for /F %%i in ('D:\\msys64\\bin\\cygpath.exe %1%') do ( set result=%%i)
rem for /f "delims=" %%t in ('D:\\msys64\\bin\\cygpath.exe %1%') do set result=%%t
echo "open: %result%"

rem D:\\msys64\\mingw64\\bin\\emacsclient.exe --no-wait --socket-name="D:\\msys64\\tmp\\emacs1000\\server-nw" --alternate-editor="D:\\msys64\\mingw64\\bin\\emacs.exe -Q -nw" "%1%"
D:\\msys64\\mingw64\\bin\\emacsclient.exe --no-wait --server-file="D:\\msys64\\tmp\\emacs1000\\server-nw" --alternate-editor="D:\\msys64\\mingw64\\bin\\emacs.exe -Q -nw" "%1%"
