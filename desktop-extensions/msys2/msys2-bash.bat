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
cd "%args%"

:eof
set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%
rem @call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Preview\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\2019\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
rem @call "%VCINSTALLDIR%\\Auxiliary\\Build\\vcvarsall.bat" x64

bash
