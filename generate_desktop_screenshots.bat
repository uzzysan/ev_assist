@echo off
setlocal EnableDelayedExpansion

echo 🖥️ EV Assist Desktop Screenshot Generator
echo ==========================================
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
if not exist integration_test\desktop_screenshots_test.dart (
    echo ❌ Error: integration_test\desktop_screenshots_test.dart not found
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)
echo ✅ Found desktop screenshot test

REM Clean and get dependencies
echo 🧹 Cleaning and getting dependencies...
flutter clean
flutter pub get

REM Run desktop integration tests for screenshots
echo 📸 Generating screenshots on Windows desktop...
flutter test integration_test\desktop_screenshots_test.dart --device-id=windows --verbose

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
    echo   │   ├── iphone_5_5
    echo   │   └── android_phone
    echo   └── tablet\
    echo       ├── ipad_pro_12_9
    echo       ├── ipad_10_9
    echo       └── android_tablet
    echo.
    echo Each device folder contains:
    echo   ├── light\ (light theme screenshots)
    echo   └── dark\  (dark theme screenshots)
    echo.
) else (
    echo ❌ Screenshot generation failed with exit code !EXIT_CODE!
    echo.
    echo Troubleshooting:
    echo 1. Make sure you're running from the project root directory
    echo 2. Ensure Flutter is properly installed and in your PATH
    echo 3. Check that all dependencies are installed: flutter pub get
    echo 4. Verify Windows desktop support: flutter config --enable-windows-desktop
    echo.
)

echo Press any key to exit...
pause >nul