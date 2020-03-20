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

cd "%*"
set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem VS2017
if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Preview\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Preview\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Community\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\2017\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Professional\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Professional\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Enterprise\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\Enterprise\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem VS2019
if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Preview\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Preview\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Community\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\2019\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Professional\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Professional\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Enterprise\\VC\\" ( 
	@call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Enterprise\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

rem %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rem Bash

rem @call "%VCINSTALLDIR%\\Auxiliary\\Build\\vcvarsall.bat" x64
D:\\msys64\\usr\\bin\\bash
