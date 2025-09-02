@echo off
echo Pulling Android screenshots from device...
echo.

REM Create screenshots directory if it doesn't exist
if not exist "screenshots" mkdir screenshots
if not exist "screenshots\phone" mkdir screenshots\phone
if not exist "screenshots\tablet" mkdir screenshots\tablet

echo Checking device connectivity...
adb devices

echo.
echo Pulling screenshots from all possible locations on Android device...

REM Try pulling from the main test directory
echo Attempting to pull from ev_assist_screenshots location...
adb pull /data/user/0/com.example.ev_assist/code_cache/ev_assist_screenshots/screenshots/ ./screenshots/ 2>nul

REM Try pulling from the simplified Android test directory  
echo Attempting to pull from android_screenshots location...
adb pull /data/user/0/com.example.ev_assist/code_cache/android_screenshots/screenshots/ ./screenshots/ 2>nul

echo.
echo Checking what we got...
dir screenshots /s /b *.png 2>nul
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Screenshots found and copied to project folder!
    echo Location: %CD%\screenshots\
) else (
    echo.
    echo ❌ No screenshots found yet.
    echo The generation process might still be running.
)

echo.
echo Also checking device for any PNG files in app directory...
adb shell "find /data/user/0/com.example.ev_assist -name '*.png' 2>/dev/null"

echo.
pause