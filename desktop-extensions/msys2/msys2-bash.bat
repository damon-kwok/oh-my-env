@echo off

rem echo %1
rem pause

rem set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%
rem if %1 EQU "" (
rem 	D:\\msys64\\usr\\bin\\bash -c neofetch
rem 	D:\\msys64\\usr\\bin\\bash
rem ) else (
rem 	D:\\msys64\\usr\\bin\\bash -c "%1"
rem 	if %2 NEQ "" (
rem 		D:\\msys64\\usr\\bin\\bash -c neofetch
rem 		D:\\msys64\\usr\\bin\\bash
rem 	)
rem )

rem pause

set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%
cd %1
bash
