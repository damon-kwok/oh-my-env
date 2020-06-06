@echo off

:: echo %1
:: pause

:: set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;%PATH%
:: if %1 EQU "" (
::     D:\\msys64\\usr\\bin\\bash -c neofetch
::     D:\\msys64\\usr\\bin\\bash
:: ) else (
::     D:\\msys64\\usr\\bin\\bash -c "%1"
::     if %2 NEQ "" (
::         D:\\msys64\\usr\\bin\\bash -c neofetch
::         D:\\msys64\\usr\\bin\\bash
::     )
:: )

:: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:: VS2017
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

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\BuildTools\\VC\\" ( 
    @call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2017\\BuildTools\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

:: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:: VS2019
if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Preview\\VC\\" ( 
    @call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Preview\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
    rem @call "%PROGRAMFILES(x86)%\Microsoft Visual Studio\\2019\\Preview\\Common7\\Tools\\VsDevCmd.bat"
    set PATH="%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\Preview\\MSBuild\\Current\\Bin\\amd64";%PATH%
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

if exist "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\" ( 
    @call "%PROGRAMFILES(x86)%\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvarsall.bat" x64
)

:: @call "%VCINSTALLDIR%\\Auxiliary\\Build\\vcvarsall.bat" x64

:: %comspec% /k "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\Common7\Tools\VsDevCmd.bat"

:: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:: Bash
:: cd "%*"

set PATH=D:\\msys64\\mingw64\\bin;D:\\msys64\\usr\\bin;D:\\msys64\\usr\\local\\bin;%PATH%
:: bash -c neofetch
bash
