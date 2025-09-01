@echo off
REM EV Assist Screenshot Generator - Windows Batch Script
echo 🚀 EV Assist Screenshot Generator
echo.

REM Check if Dart is available
where dart >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Error: Dart not found in PATH
    echo Please ensure Flutter SDK is installed and in your PATH
    pause
    exit /b 1
)

REM Check if we're in the right directory
if not exist pubspec.yaml (
    echo ❌ Error: Must run from project root (where pubspec.yaml exists)
    pause
    exit /b 1
)

REM Create scripts directory if it doesn't exist
if not exist scripts mkdir scripts

REM Run the Dart script with all arguments
dart scripts/generate_screenshots.dart %*

REM Pause to see results
echo.
echo Press any key to exit...
pause >nul