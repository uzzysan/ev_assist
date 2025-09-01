@echo off
echo 🧪 AdMob Configuration Test Script
echo ===================================
echo.

echo This script helps you test both AdMob modes:
echo.
echo 1. DEBUG MODE (Test Ads):
echo    - Uses Google's test AdMob IDs
echo    - Shows orange "TEST ADS MODE" banner
echo    - Safe for development and testing
echo.
echo 2. RELEASE MODE (Production Ads):
echo    - Uses your real AdMob IDs
echo    - Shows your actual ads
echo    - For production builds only
echo.

:menu
echo Choose an option:
echo [1] Run in DEBUG mode (Test Ads)
echo [2] Build RELEASE APK (Production Ads)
echo [3] Show current AdMob configuration
echo [4] Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto debug_mode
if "%choice%"=="2" goto release_mode
if "%choice%"=="3" goto show_config
if "%choice%"=="4" goto exit
echo Invalid choice. Please try again.
echo.
goto menu

:debug_mode
echo.
echo 🧪 Running in DEBUG mode with test ads...
echo You should see an orange "TEST ADS MODE" banner
echo.
flutter run
goto menu

:release_mode
echo.
echo 🚀 Building RELEASE APK with production ads...
echo This will use your real AdMob IDs
echo.
flutter build apk --release
echo.
echo ✅ Release APK built successfully!
echo Location: build/app/outputs/flutter-apk/app-release.apk
echo.
goto menu

:show_config
echo.
echo 📋 Current AdMob Configuration:
echo ==============================
echo.
echo DEBUG MODE (Test Ads):
echo   App ID: ca-app-pub-3940256099942544~3347511713
echo   Banner ID: ca-app-pub-3940256099942544/6300978111
echo.
echo RELEASE MODE (Production Ads):
echo   App ID: ca-app-pub-3287491879097224~2214382527
echo   Banner ID: ca-app-pub-3287491879097224/8588219186
echo.
goto menu

:exit
echo.
echo 👋 Goodbye!
pause