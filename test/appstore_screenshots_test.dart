import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  group('App Store Screenshots', () {
    late Directory screenshotsDir;

    setUpAll(() async {
      // Find project root
      Directory projectRoot = Directory.current;
      var attempts = 0;
      while (projectRoot.path != projectRoot.parent.path && attempts < 10) {
        if (File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync()) {
          break;
        }
        projectRoot = projectRoot.parent;
        attempts++;
      }

      // Create screenshots directory
      final screenshotsPath = path.join(projectRoot.path, 'screenshots');
      screenshotsDir = Directory(screenshotsPath);
      
      if (await screenshotsDir.exists()) {
        await screenshotsDir.delete(recursive: true);
      }
      await screenshotsDir.create(recursive: true);
      
      print('📁 Screenshots będą zapisane w: ${screenshotsDir.path}');
    });

    // Konfiguracje urządzeń dla App Store
    final devices = [
      {
        'name': 'iPhone_6_7_inch',
        'size': const Size(414, 896),
        'folder': 'phone',
        'description': 'iPhone 11, 12, 13, 14'
      },
      {
        'name': 'iPhone_6_5_inch', 
        'size': const Size(390, 844),
        'folder': 'phone',
        'description': 'iPhone 12 Pro, 13 Pro, 14 Pro'
      },
      {
        'name': 'iPad_Pro_12_9_inch',
        'size': const Size(1024, 1366),
        'folder': 'tablet', 
        'description': 'iPad Pro 12.9"'
      },
      {
        'name': 'iPad_10_9_inch',
        'size': const Size(834, 1194),
        'folder': 'tablet',
        'description': 'iPad Air, iPad Pro 11"'
      },
    ];

    final themes = [
      {'mode': ThemeMode.light, 'name': 'light', 'description': 'Jasny motyw'},
      {'mode': ThemeMode.dark, 'name': 'dark', 'description': 'Ciemny motyw'},
    ];

    final locales = [
      {'locale': const Locale('en'), 'name': 'English'},
      {'locale': const Locale('pl'), 'name': 'Polish'},
    ];

    for (final device in devices) {
      for (final theme in themes) {
        for (final localeConfig in locales) {
          final testName = '${device['name']}_${localeConfig['name']}_${theme['name']}';
          
          testWidgets(testName, (WidgetTester tester) async {
            print('📱 Generowanie screenshot: $testName');
            
            // Ustaw rozmiar urządzenia
            await tester.binding.setSurfaceSize(device['size'] as Size);
            tester.binding.window.devicePixelRatioTestValue = 2.0;
            
            // Utwórz aplikację z określonymi ustawieniami
            await tester.pumpWidget(
              app.EvAssistApp(
                locale: localeConfig['locale'] as Locale,
                themeMode: theme['mode'] as ThemeMode,
                skipSplash: true,
              ),
            );
            
            // Czekaj aż wszystko się załaduje
            await tester.pumpAndSettle(const Duration(milliseconds: 500));
            
            // Wypełnij przykładowe dane
            await _fillSampleData(tester, localeConfig['locale'] as Locale);
            await tester.pumpAndSettle(const Duration(milliseconds: 300));
            
            // Zrób screenshot
            await _saveScreenshot(
              tester,
              screenshotsDir,
              device['folder'] as String,
              device['name'] as String,
              theme['name'] as String,
              localeConfig['name'] as String,
            );
            
            print('✅ Screenshot zapisany: $testName');
          });
        }
      }
    }
  });
}

Future<void> _fillSampleData(WidgetTester tester, Locale locale) async {
  try {
    final textFields = find.byType(TextFormField);
    final fieldCount = textFields.evaluate().length;
    
    print('🔍 Znaleziono $fieldCount pól tekstowych');
    
    if (fieldCount >= 6) {
      // Dane przykładowe dostosowane do lokalizacji
      final decimalSeparator = locale.languageCode == 'pl' ? ',' : '.';
      
      final sampleData = [
        '18${decimalSeparator}5', // Średnie zużycie
        '100',                    // Dystans bazowy  
        '285',                    // Dystans do celu
        '75',                     // Pojemność baterii
        '80',                     // Aktualny poziom baterii
        '20',                     // Pożądany poziom na miejscu
      ];
      
      for (int i = 0; i < sampleData.length && i < fieldCount; i++) {
        await tester.enterText(textFields.at(i), sampleData[i]);
        await tester.pump(const Duration(milliseconds: 200));
      }
      
      print('✅ Dane przykładowe wypełnione pomyślnie');
    }
  } catch (e) {
    print('⚠️ Błąd podczas wypełniania danych: $e');
  }
}

Future<void> _saveScreenshot(
  WidgetTester tester,
  Directory screenshotsDir,
  String deviceType,
  String deviceName,
  String theme,
  String locale,
) async {
  try {
    // Utwórz strukturę folderów: screenshots/phone/iPhone_6_7_inch/light/
    final deviceDir = Directory(path.join(
      screenshotsDir.path,
      deviceType,
      deviceName,
      theme,
    ));
    await deviceDir.create(recursive: true);
    
    final fileName = '${locale.toLowerCase()}_main.png';
    final filePath = path.join(deviceDir.path, fileName);

    // Use golden file approach for consistent screenshots
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile(filePath),
    );
    
    print('📸 Screenshot zapisany: $filePath');
  } catch (e, stackTrace) {
    print('❌ Błąd podczas zapisywania screenshot\'a: $e');
    print('Stack trace: $stackTrace');
  }
}
