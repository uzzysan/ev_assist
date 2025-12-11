@echo off
echo 📱 Generowanie screenshotów dla App Store...
echo.

REM Sprawdź czy Flutter jest dostępny
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Flutter nie jest zainstalowany lub nie jest w PATH
    pause
    exit /b 1
)

REM Sprawdź czy pubspec.yaml istnieje
if not exist "pubspec.yaml" (
    echo ❌ Nie znaleziono pubspec.yaml w bieżącym katalogu
    echo Upewnij się, że jesteś w głównym katalogu projektu Flutter
    pause
    exit /b 1
)

REM Utwórz folder screenshots jeśli nie istnieje
if not exist "screenshots" (
    mkdir "screenshots"
)

echo 🏗️ Pobieranie zależności...
flutter pub get
if %errorlevel% neq 0 (
    echo ❌ Błąd podczas pobierania zależności
    pause
    exit /b 1
)

echo.
echo 🎯 Uruchamianie testów screenshotów...
echo Testy będą uruchamiane dla następujących konfiguracji:
echo - Urządzenia: iPhone 6.7", iPhone 6.5", iPad Pro 12.9", iPad 10.9"
echo - Motywy: jasny i ciemny
echo - Języki: angielski i polski
echo.

REM Ustaw zmienne środowiskowe dla trybu testowego
set FLUTTER_TEST=true
set NO_ADS=true
set TEST_ENV=true

REM Uruchom testy z dodatkową informacją
flutter test test/appstore_screenshots_test.dart --reporter=expanded
if %errorlevel% neq 0 (
    echo.
    echo ❌ Błąd podczas generowania screenshotów
    echo.
    echo 💡 Możliwe rozwiązania:
    echo    1. Sprawdź czy wszystkie zależności są zainstalowane: flutter pub get
    echo    2. Sprawdź czy nie ma błędów kompilacji: flutter analyze
    echo    3. Sprawdź logi powyżej dla szczegółowych informacji
    pause
    exit /b 1
)

echo.
echo ✅ Screenshoty wygenerowane pomyślnie!
echo.
echo 📁 Screenshoty zostały zapisane w katalogu 'screenshots/'
echo.
echo Struktura folderów:
echo screenshots/
echo   ├── phone/
echo   │   ├── iPhone_6_7_inch/
echo   │   │   ├── light/
echo   │   │   │   ├── english_main.png
echo   │   │   │   └── polish_main.png  
echo   │   │   └── dark/
echo   │   │       ├── english_main.png
echo   │   │       └── polish_main.png
echo   │   └── iPhone_6_5_inch/
echo   │       └── ...
echo   └── tablet/
echo       ├── iPad_Pro_12_9_inch/
echo       └── iPad_10_9_inch/
echo           └── ...
echo.

REM Sprawdź ile plików zostało utworzonych
set /a screenshot_count=0
for /r "screenshots" %%i in (*.png) do set /a screenshot_count+=1

echo 📊 Łącznie utworzono: %screenshot_count% screenshotów
echo.
echo 🎉 Gotowe! Możesz teraz użyć tych screenshotów w App Store.

pause