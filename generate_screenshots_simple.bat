@echo off
echo 🚀 EV Assist Screenshot Generator (Simple)
echo =========================================
echo.

REM Check if we're in the right directory
if not exist pubspec.yaml (
    echo ❌ Error: Must run from project root where pubspec.yaml exists
    pause
    exit /b 1
)

REM Check if Flutter is available
flutter --version >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Error: Flutter not found in PATH
    echo Please ensure Flutter SDK is installed and in your PATH
    pause
    exit /b 1
)

echo ✅ Flutter found
echo.

REM Choose test file based on arguments
set TEST_FILE=integration_test/screenshots_test.dart
if "%1"=="--enhanced" set TEST_FILE=integration_test/enhanced_screenshots_test.dart

echo 📱 Using test file: %TEST_FILE%
echo.

REM Check if test file exists
if not exist "%TEST_FILE%" (
    echo ❌ Error: %TEST_FILE% not found
    pause
    exit /b 1
)

echo 🧹 Cleaning build...
flutter clean

echo.
echo 📦 Getting dependencies...
flutter pub get

echo.
echo 📸 Running screenshot tests...
echo This may take several minutes...
echo.

flutter test "%TEST_FILE%" --verbose

if %errorlevel% equ 0 (
    echo.
    echo ✅ Screenshot generation completed!
    echo Check the console output above for screenshot locations.
) else (
    echo.
    echo ❌ Screenshot generation failed. Check the output above for details.
)

echo.
pause