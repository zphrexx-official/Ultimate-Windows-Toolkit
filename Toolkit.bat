@echo off
title Ultimate Windows Toolkit v1.1
color 0B

net session >nul 2>&1

if not %errorlevel%==0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)


cls
echo.
echo ======================================
echo.
echo       ULTIMATE WINDOWS TOOLKIT
echo.
echo              Version 1.1
echo.
echo           Made by zphrexx
echo.
echo ======================================
echo.

timeout /t 3 >nul


:menu
cls
echo ======================================
echo       ULTIMATE WINDOWS TOOLKIT
echo ======================================
echo.
echo [1] System Tools
echo [2] Cleanup Tools
echo [3] Network Tools
echo [4] Diagnostics
echo [5] Developer Tools
echo [6] Quick Actions
echo [7] Fun
echo.
echo [0] Exit
echo.

set /p choice=Choose:

if %choice%==1 goto system
if %choice%==2 goto cleanup
if %choice%==3 goto network
if %choice%==4 goto diagnostics
if %choice%==5 goto developer
if %choice%==6 goto quick
if %choice%==7 goto fun
if %choice%==7391 goto adminmenu
if %choice%==0 exit

goto menu


:menu
cls
echo ======================================
echo       ULTIMATE WINDOWS TOOLKIT
echo ======================================
echo.
echo [1] System Tools
echo [2] Cleanup Tools
echo [3] Network Tools
echo [4] Diagnostics
echo [5] Developer Tools
echo [6] Quick Actions
echo [7] Fun
echo.
echo [0] Exit
echo.

set /p choice=Choose:

if %choice%==1 goto system
if %choice%==2 goto cleanup
if %choice%==3 goto network
if %choice%==4 goto diagnostics
if %choice%==5 goto developer
if %choice%==6 goto quick
if %choice%==7 goto fun
if %choice%==0 exit

goto menu



:system
cls
echo ======================================
echo            SYSTEM TOOLS
echo ======================================
echo.
echo [1] PC Information
echo [2] Restart Explorer
echo [3] Control Panel
echo [4] Task Manager
echo [5] Windows Settings
echo [6] GPU Information
echo [7] Battery Report
echo [8] Windows Version
echo [0] Menu
echo.

set /p sys=Choose:

if %sys%==1 goto pcinfo
if %sys%==2 goto explorer
if %sys%==3 start control & goto system
if %sys%==4 start taskmgr & goto system
if %sys%==5 start ms-settings: & goto system
if %sys%==6 goto gpu
if %sys%==7 goto battery
if %sys%==8 start winver & goto system
if %sys%==0 goto menu

goto system



:pcinfo
cls
systeminfo
pause
goto system



:explorer
cls
echo Restarting Explorer...
taskkill /f /im explorer.exe
start explorer.exe
echo Done!
pause
goto system



:gpu
cls
echo ======================================
echo              GPU INFO
echo ======================================
echo.

wmic path win32_VideoController get name

pause
goto system



:battery
cls
echo ======================================
echo          BATTERY REPORT
echo ======================================
echo.

powercfg /batteryreport

echo.
echo Battery report created!
pause
goto system





:cleanup
cls
echo ======================================
echo          CLEANUP TOOLS
echo ======================================
echo.
echo [1] Clean Temp Files
echo [2] Empty Recycle Bin
echo [3] Clear DNS Cache
echo [0] Menu
echo.

set /p clean=Choose:

if %clean%==1 goto temp
if %clean%==2 goto recycle
if %clean%==3 goto dns
if %clean%==0 goto menu

goto cleanup



:temp
cls
echo Cleaning Temp Files...

del /q /f /s %temp%\* >nul 2>&1

echo.
echo Temp cleaned!
pause
goto cleanup



:recycle
cls
echo ======================================
echo        EMPTY RECYCLE BIN
echo ======================================
echo.

powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

echo.
echo Recycle Bin cleaned (or already empty)!
pause
goto cleanup



:dns
cls
ipconfig /flushdns
pause
goto cleanup


:network
cls
echo ======================================
echo          NETWORK TOOLS
echo ======================================
echo.
echo [1] Show IP Address
echo [2] Show WiFi Profiles
echo [3] Show Saved WiFi Passwords
echo [4] Ping Test
echo [5] Flush DNS
echo [6] Network Information
echo [7] Open Network Settings
echo [0] Menu
echo.

set /p net=Choose:

if %net%==1 ipconfig & pause & goto network

if %net%==2 netsh wlan show profiles & pause & goto network

if %net%==3 goto wifipass

if %net%==4 ping google.com & pause & goto network

if %net%==5 ipconfig /flushdns & pause & goto network

if %net%==6 ipconfig /all & pause & goto network

if %net%==7 start ms-settings:network & goto network

if %net%==0 goto menu

goto network



:wifipass
setlocal EnableDelayedExpansion

cls
echo ======================================
echo       SAVED WIFI PASSWORDS
echo ======================================
echo.

for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (

    set wifi=%%a
    set wifi=!wifi:~1!

    echo WiFi: !wifi!

    netsh wlan show profile name="!wifi!" key=clear | findstr "Key Content"

    echo.
)

echo.
pause

endlocal
goto network


:diagnostics
cls
echo ======================================
echo          DIAGNOSTICS
echo ======================================
echo.
echo [1] Check System Files
echo [2] DISM Health Check
echo [3] Task List
echo [4] Startup Programs
echo [5] Disk Space
echo [6] Device Manager
echo [7] DirectX Diagnostic Tool
echo [8] Windows Event Viewer
echo [0] Menu
echo.

set /p diag=Choose:

if %diag%==1 sfc /scannow & pause & goto diagnostics

if %diag%==2 DISM /Online /Cleanup-Image /RestoreHealth & pause & goto diagnostics

if %diag%==3 tasklist & pause & goto diagnostics

if %diag%==4 wmic startup get caption,command & pause & goto diagnostics

if %diag%==5 wmic logicaldisk get name,size,freespace & pause & goto diagnostics

if %diag%==6 start devmgmt.msc & goto diagnostics

if %diag%==7 start dxdiag & goto diagnostics

if %diag%==8 start eventvwr & goto diagnostics

if %diag%==0 goto menu

goto diagnostics


:developer
cls
echo ======================================
echo          DEVELOPER TOOLS
echo ======================================
echo.
echo [1] Python Version
echo [2] Pip Packages
echo [3] Java Version
echo [4] Git Version
echo [5] Open VS Code
echo [6] Open Current Folder
echo [7] Create Project Folder
echo [8] System PATH
echo [0] Menu
echo.

set /p dev=Choose:

if %dev%==1 python --version & pause & goto developer

if %dev%==2 pip list & pause & goto developer

if %dev%==3 java -version & pause & goto developer

if %dev%==4 git --version & pause & goto developer

if %dev%==5 code . & goto developer

if %dev%==6 start . & goto developer

if %dev%==7 goto createproject

if %dev%==8 path & pause & goto developer

if %dev%==0 goto menu

goto developer



:createproject
cls
echo ======================================
echo       CREATE PROJECT FOLDER
echo ======================================
echo.

set /p name=Project name:

mkdir "%name%"

echo.
echo Project created!
pause
goto developer



:quick
cls
echo ======================================
echo          QUICK ACTIONS
echo ======================================
echo.
echo [1] Restart PC
echo [2] Shutdown PC
echo [3] Lock PC
echo [4] Sleep Mode
echo [5] Task Manager
echo [6] File Explorer
echo [7] CMD
echo [0] Menu
echo.

set /p quick=Choose:

if %quick%==1 shutdown /r /t 5

if %quick%==2 shutdown /s /t 5

if %quick%==3 rundll32.exe user32.dll,LockWorkStation

if %quick%==4 rundll32.exe powrprof.dll,SetSuspendState 0,1,0

if %quick%==5 start taskmgr & goto quick

if %quick%==6 start explorer & goto quick

if %quick%==7 start cmd & goto quick

if %quick%==0 goto menu

goto quick



:adminmenu
cls
echo ======================================
echo            ADMIN MENU
echo ======================================
echo.
echo [1] Restart Toolkit
echo [2] Restart Explorer
echo [3] Open CMD as Admin
echo [4] Task Manager
echo [5] Kill Process
echo [6] God Mode Folder
echo [0] Menu
echo.

set /p admin=Choose:


if %admin%==1 (
    start "" "%~f0"
    exit
)


if %admin%==2 (
    taskkill /f /im explorer.exe
    start explorer.exe
    goto adminmenu
)


if %admin%==3 (
    powershell -Command "Start-Process cmd -Verb RunAs"
    goto adminmenu
)


if %admin%==4 (
    start taskmgr
    goto adminmenu
)


if %admin%==5 goto killprocess


if %admin%==6 goto godmode


if %admin%==0 goto menu


goto adminmenu



:killprocess
cls
echo ======================================
echo          KILL PROCESS
echo ======================================
echo.

set /p process=Process name:

taskkill /f /im %process%

echo.
echo Process closed!
pause
goto adminmenu



:godmode
cls
echo ======================================
echo          GOD MODE FOLDER
echo ======================================
echo.
echo Where create folder?
echo.
echo [1] Desktop
echo [2] Documents
echo [3] Downloads
echo [4] Toolkit Folder
echo [0] Menu
echo.

set /p location=Choose:

if %location%==1 set folder=%userprofile%\Desktop

if %location%==2 set folder=%userprofile%\Documents

if %location%==3 set folder=%userprofile%\Downloads

if %location%==4 set folder=%~dp0

if %location%==0 goto adminmenu


mkdir "%folder%\God Mode.{ED7BA470-8E54-465E-825C-99712043E01C}" 2>nul


echo.
echo God Mode Folder created!
echo.
echo Location:
echo %folder%

pause
goto adminmenu


:fun
cls
echo ======================================
echo              FUN
echo ======================================
echo.
echo [1] Matrix Effect
echo [2] Fake Hacker Screen
echo [3] Loading Animation
echo [4] Random Password Generator
echo [5] Color Test
echo [6] ASCII Art
echo [0] Menu
echo.

set /p fun=Choose:

if %fun%==1 goto matrix

if %fun%==2 goto hacker

if %fun%==3 goto loading

if %fun%==4 goto password

if %fun%==5 goto colors

if %fun%==6 goto ascii

if %fun%==0 goto menu

goto fun



:hacker
cls
color 0A
echo Connecting to server...
timeout /t 1 >nul
echo Searching database...
timeout /t 1 >nul
echo Bypassing firewall...
timeout /t 1 >nul
echo Access granted!
timeout /t 1 >nul
echo.
echo Just kidding!
pause
goto fun



:loading
cls
echo Loading Ultimate Toolkit...
timeout /t 1 >nul
echo [=====     ] 50%%
timeout /t 1 >nul
echo [==========] 100%%
echo Done!
pause
goto fun



:password
cls
echo Random Password:
echo %random%%random%%random%
pause
goto fun



:colors
cls
color 0C
echo RED
timeout /t 1 >nul
color 0A
echo GREEN
timeout /t 1 >nul
color 09
echo BLUE
timeout /t 1 >nul
color 0B
echo CYAN
pause
goto fun



:ascii
cls
echo        /\
echo       /  \
echo      /____\
echo      ^| [] ^|
echo      ^|____^|
pause
goto fun



:matrix
cls
color 0A
mode 100

:loop
echo %random%%random%%random%%random%%random%
goto loop