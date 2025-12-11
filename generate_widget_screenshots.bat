@echo off
setlocal EnableDelayedExpansion

echo 🖼️ EV Assist Widget Screenshot Generator
echo =========================================
echo.

REM Check if Flutter is available
flutter --version >nul 2>nul
if !errorlevel! neq 0 (
    echo ❌ Error: Flutter not found in PATH
    echo Please ensure Flutter SDK is installed and in your PATH
    echo.
    pause
    exit /b 1
)
echo ✅ Flutter found

REM Check if we're in the right directory
if not exist pubspec.yaml (
    echo ❌ Error: Must run from project root where pubspec.yaml exists
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)
echo ✅ Found pubspec.yaml

REM Check if the test file exists
if not exist test\screenshot_widget_test.dart (
    echo ❌ Error: test\screenshot_widget_test.dart not found
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)
echo ✅ Found widget screenshot test

REM Clean and get dependencies
echo 🧹 Cleaning and getting dependencies...
flutter clean
flutter pub get

REM Run widget tests for screenshots
echo 📸 Generating screenshots using widget tests...
flutter test test\screenshot_widget_test.dart --verbose

set EXIT_CODE=!errorlevel!

echo.
if !EXIT_CODE! equ 0 (
    echo ✅ Screenshot generation completed successfully!
    echo.
    echo 📁 Screenshots should be saved in: %CD%\screenshots\
    echo   📱 Phone screenshots: screenshots\phone\
    echo   📟 Tablet screenshots: screenshots\tablet\
    echo.
    echo Directory structure:
    echo   screenshots\
    echo   ├── phone\
    echo   │   ├── iphone_6_7\
    echo   │   ├── iphone_6_5
    echo   │   └── android_phone
    echo   └── tablet\
    echo       ├── ipad_pro_12_9
    echo       └── android_tablet
    echo.
    echo Each device folder contains:
    echo   ├── light\ (light theme screenshots)
    echo   └── dark\  (dark theme screenshots)
    echo.
    echo Each theme folder contains:
    echo   ├── en_main.png (English version)
    echo   └── pl_main.png (Polish version)
    echo.
) else (
    echo ❌ Screenshot generation failed with exit code !EXIT_CODE!
    echo.
    echo Troubleshooting:
    echo 1. Make sure you're running from the project root directory
    echo 2. Ensure Flutter is properly installed and in your PATH
    echo 3. Check that all dependencies are installed: flutter pub get
    echo 4. Try running: flutter test test\screenshot_widget_test.dart
    echo.
)

echo Press any key to exit...
pause >nul