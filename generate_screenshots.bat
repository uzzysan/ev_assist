@echo off
setlocal EnableDelayedExpansion

echo 🚀 EV Assist Screenshot Generator
echo ==================================
echo.

REM Check if Flutter is available (which includes Dart)
flutter --version >nul 2>nul
if !errorlevel! neq 0 (
    echo ❌ Error: Flutter not found in PATH
    echo Please ensure Flutter SDK is installed and in your PATH
    echo.
    pause
    exit /b 1
)
echo ✅ Flutter found in PATH

REM Check if we're in the right directory
if not exist pubspec.yaml (
    echo ❌ Error: Must run from project root where pubspec.yaml exists
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)
echo ✅ Found pubspec.yaml

REM Check if the Dart script exists
if not exist scripts\generate_screenshots.dart (
    echo ❌ Error: scripts\generate_screenshots.dart not found
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)
echo ✅ Found Dart script

REM Show what we're about to run
echo 🔄 Running: dart scripts\generate_screenshots.dart %*
echo.

REM Run the Dart script with all arguments
dart scripts\generate_screenshots.dart %*
set DART_EXIT_CODE=!errorlevel!

echo.
if !DART_EXIT_CODE! equ 0 (
    echo ✅ Screenshot generation completed successfully!
) else (
    echo ❌ Screenshot generation failed with exit code !DART_EXIT_CODE!
)

echo.
echo Press any key to exit...
pause >nul