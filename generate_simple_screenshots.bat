@echo off
setlocal EnableDelayedExpansion

echo 🎯 EV Assist Golden File Screenshot Generator
echo =============================================
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
if not exist test\simple_screenshots_test.dart (
    echo ❌ Error: test\simple_screenshots_test.dart not found
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)
echo ✅ Found simple screenshot test

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Generate golden files (these are the screenshots)
echo 📸 Generating golden file screenshots...
echo This will create PNG files in test\golden\ directory
echo.

flutter test test\simple_screenshots_test.dart --update-goldens

set EXIT_CODE=!errorlevel!

echo.
if !EXIT_CODE! equ 0 (
    echo ✅ Golden file generation completed successfully!
    echo.
    echo 📁 Screenshots (golden files) saved in: %CD%\test\golden\
    echo.
    echo Generated files:
    if exist test\golden\golden_iphone_6_7_en_light.png (
        echo   ✅ iphone_6_7_en_light.png
    ) else (
        echo   ❌ iphone_6_7_en_light.png (not found)
    )
    if exist test\golden\golden_iphone_6_7_en_dark.png (
        echo   ✅ iphone_6_7_en_dark.png  
    ) else (
        echo   ❌ iphone_6_7_en_dark.png (not found)
    )
    if exist test\golden\golden_ipad_pro_12_9_en_light.png (
        echo   ✅ ipad_pro_12_9_en_light.png
    ) else (
        echo   ❌ ipad_pro_12_9_en_light.png (not found)
    )
    if exist test\golden\golden_iphone_6_7_pl_light.png (
        echo   ✅ iphone_6_7_pl_light.png
    ) else (
        echo   ❌ iphone_6_7_pl_light.png (not found)
    )
    echo.
    echo 🎯 These are your app store ready screenshots!
    echo You can copy them from test\golden\ to use for app store submissions.
    echo.
) else (
    echo ❌ Golden file generation failed with exit code !EXIT_CODE!
    echo.
    echo Troubleshooting:
    echo 1. Make sure you're running from the project root directory
    echo 2. Ensure Flutter is properly installed and in your PATH
    echo 3. Check that all dependencies are installed: flutter pub get
    echo 4. Try running manually: flutter test test\simple_screenshots_test.dart --update-goldens
    echo.
)

echo Press any key to exit...
pause >nul