import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Mobile-like sizes for screenshots
  final Map<String, Size> deviceSizes = {
    'android_phone': const Size(360, 640), // Standard Android phone
    'android_tablet': const Size(800, 1280), // Standard Android tablet
  };

  // Only Polish and English
  final List<Locale> locales = [
    const Locale('en'),
    const Locale('pl'),
  ];

  // Both themes
  final List<ThemeMode> themes = [
    ThemeMode.light,
    ThemeMode.dark,
  ];

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Create screenshots directory in project root
  late Directory screenshotsDir;
  
  setUpAll(() async {
    // Save directly to project screenshots folder
    final projectPath = Directory.current.path;
    screenshotsDir = Directory(path.join(projectPath, 'screenshots'));
    
    debugPrint('Project path: $projectPath');
    debugPrint('Screenshots directory: ${screenshotsDir.path}');
    
    if (await screenshotsDir.exists()) {
      await screenshotsDir.delete(recursive: true);
    }
    await screenshotsDir.create(recursive: true);
    
    debugPrint('Screenshots will be saved to: ${screenshotsDir.path}');
  });

  for (final deviceName in deviceSizes.keys) {
    final deviceSize = deviceSizes[deviceName]!;
    final isTablet = deviceName.contains('tablet');
    final deviceType = isTablet ? 'tablet' : 'phone';

    for (final locale in locales) {
      for (final theme in themes) {
        final themeString = theme == ThemeMode.light ? 'light' : 'dark';
        
        testWidgets('${deviceName}_${locale.languageCode}_$themeString Main screen', (tester) async {
          // Set device size
          await tester.binding.setSurfaceSize(deviceSize);
          
          await tester.pumpWidget(
            app.EvAssistApp(locale: locale, themeMode: theme),
          );
          await tester.pumpAndSettle(const Duration(seconds: 5));
          
          // Fill in sample data
          await _fillSampleData(tester);
          await tester.pumpAndSettle(const Duration(seconds: 1));
          
          await _takeScreenshot(
            binding, 
            screenshotsDir, 
            deviceType,
            deviceName, 
            locale.languageCode, 
            themeString, 
            'main',
          );
        });

        testWidgets('${deviceName}_${locale.languageCode}_$themeString Settings screen', (tester) async {
          // Set device size
          await tester.binding.setSurfaceSize(deviceSize);
          
          await tester.pumpWidget(
            app.EvAssistApp(locale: locale, themeMode: theme),
          );
          await tester.pumpAndSettle(const Duration(seconds: 5));
          
          // Navigate to settings
          final settingsButton = find.byIcon(Icons.settings);
          await tester.tap(settingsButton);
          await tester.pumpAndSettle(const Duration(seconds: 1));
          
          await _takeScreenshot(
            binding, 
            screenshotsDir, 
            deviceType,
            deviceName, 
            locale.languageCode, 
            themeString, 
            'settings',
          );
        });

        testWidgets('${deviceName}_${locale.languageCode}_$themeString Language menu', (tester) async {
          // Set device size
          await tester.binding.setSurfaceSize(deviceSize);
          
          await tester.pumpWidget(
            app.EvAssistApp(locale: locale, themeMode: theme),
          );
          await tester.pumpAndSettle(const Duration(seconds: 5));
          
          // Navigate to language menu
          final languageButton = find.byIcon(Icons.language);
          await tester.tap(languageButton);
          await tester.pumpAndSettle(const Duration(seconds: 1));
          
          await _takeScreenshot(
            binding, 
            screenshotsDir, 
            deviceType,
            deviceName, 
            locale.languageCode, 
            themeString, 
            'language_menu',
          );
        });
      }
    }
  }
}

Future<void> _fillSampleData(WidgetTester tester) async {
  // Wait for text fields to be available
  await tester.pumpAndSettle(const Duration(seconds: 3));
  
  try {
    // Find text fields by their input decorations or controllers
    final textFields = find.byType(TextFormField);
    
    if (textFields.evaluate().length >= 6) {
      // Fill consumption fields
      await tester.enterText(textFields.at(0), '18.5');
      await tester.pump(const Duration(milliseconds: 200));
      
      await tester.enterText(textFields.at(1), '100');
      await tester.pump(const Duration(milliseconds: 200));
      
      // Fill destination distance
      await tester.enterText(textFields.at(2), '250');
      await tester.pump(const Duration(milliseconds: 200));
      
      // Fill battery capacity
      await tester.enterText(textFields.at(3), '77');
      await tester.pump(const Duration(milliseconds: 200));
      
      // Fill current battery level
      await tester.enterText(textFields.at(4), '65');
      await tester.pump(const Duration(milliseconds: 200));
      
      // Fill desired battery level
      await tester.enterText(textFields.at(5), '20');
      await tester.pump(const Duration(milliseconds: 200));
      
      await tester.pumpAndSettle(const Duration(seconds: 1));
      debugPrint('✅ Sample data filled successfully');
    } else {
      debugPrint('⚠️ Expected 6 text fields, found ${textFields.evaluate().length}');
    }
  } catch (e) {
    debugPrint('❌ Error filling sample data: $e');
    // Continue anyway
  }
}

Future<void> _takeScreenshot(
  IntegrationTestWidgetsFlutterBinding binding,
  Directory screenshotsDir,
  String deviceType,
  String deviceName,
  String locale,
  String theme,
  String screenName,
) async {
  // Create organized directory structure
  final deviceDir = Directory(path.join(screenshotsDir.path, deviceType, deviceName, theme));
  await deviceDir.create(recursive: true);
  
  final fileName = '${locale}_$screenName.png';
  final filePath = path.join(deviceDir.path, fileName);
  
  try {
    final bytes = await binding.takeScreenshot(fileName);
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    
    debugPrint('✅ Screenshot saved: $filePath');
  } catch (e, stackTrace) {
    debugPrint('❌ Failed to save screenshot $filePath: $e');
    debugPrint(stackTrace.toString());
  }
}