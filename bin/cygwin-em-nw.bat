@echo off
echo %1%
rem /cygdrive/d/
D:\\cygwin64\\bin\\cygpath.exe %1% > emacs-open-info.log
set /P result=<emacs-open-info.log
del emacs-open-info.log

rem for /F %%i in ('D:\\cygwin64\\bin\\cygpath.exe %1%') do ( set result=%%i)
rem for /f "delims=" %%t in ('D:\\cygwin64\\bin\\cygpath.exe %1%') do set result=%%t
echo "open: %result%"

rem D:\\cygwin64\\bin\\emacsclient-w32.exe --no-wait --socket-name="D:\\cygwin64\\tmp\\emacs1000\\server-nw" --alternate-editor="D:\\cygwin64\\bin\\emacs-w32.exe -Q -nw" "%result%"
D:\\cygwin64\\bin\\emacsclient-w32.exe --no-wait --server-file="D:\\cygwin64\\tmp\\emacs1000\\server-nw" --alternate-editor="D:\\cygwin64\\bin\\emacs-w32.exe -Q -nw" "%result%"
