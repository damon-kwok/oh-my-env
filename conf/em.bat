@echo off

rem write filepath to 1.log
C:\\cygwin64\\bin\\cygpath.exe %1% >1.log

rem read filepath
set /P result=<1.log
echo "path:%result%"

C:\\cygwin64\\bin\\emacsclient-w32.exe --no-wait --socket-name="/cygdrive/c/cygwin64/home/damon/.emacs.d/server/server" --alternate-editor="C:\\cygwin64\\bin\\emacs-w32.exe" %result%
