@echo off
echo Looking for screenshots in temp directories...

REM Check various possible temp locations
set TEMP_LOCATIONS[0]=%TEMP%\ev_assist_screenshots\screenshots
set TEMP_LOCATIONS[1]=%LOCALAPPDATA%\Temp\ev_assist_screenshots\screenshots
set TEMP_LOCATIONS[2]=%USERPROFILE%\AppData\Local\Temp\ev_assist_screenshots\screenshots

echo Checking temp locations for screenshots...
for /L %%i in (0,1,2) do (
    call set TEMP_PATH=%%TEMP_LOCATIONS[%%i]%%
    call :checkLocation "!TEMP_PATH!"
)

echo Checking for Android device screenshot location...
adb shell "find /data/user/0/com.example.ev_assist/code_cache/ev_assist_screenshots/screenshots -name '*.png' 2>/dev/null" > temp_list.txt
if %ERRORLEVEL% NEQ 0 (
    echo Checking alternative Android location...
    adb shell "find /data/user/0/com.example.ev_assist/code_cache/android_screenshots/screenshots -name '*.png' 2>/dev/null" > temp_list.txt
)
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=*" %%a in (temp_list.txt) do (
        echo Found: %%a
        adb pull "%%a" "screenshots\"
    )
)
del temp_list.txt 2>nul

echo Done! Check the screenshots folder.
pause
goto :eof

:checkLocation
if exist %1 (
    echo Found screenshots at: %1
    if not exist "screenshots" mkdir screenshots
    xcopy /E /I /Y %1 screenshots\
    echo Screenshots copied to project folder!
) else (
    echo Not found: %1
)
goto :eof