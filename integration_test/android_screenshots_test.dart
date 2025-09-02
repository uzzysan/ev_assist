import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Only Android devices
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
    // Try to find project root or use temp directory
    Directory? projectRoot;
    
    // Try to find project root by looking for pubspec.yaml
    projectRoot = Directory.current;
    var attempts = 0;
    while (projectRoot != null && 
           !File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync() && 
           attempts < 10) {
      final parent = projectRoot.parent;
      if (parent.path == projectRoot.path) {
        break;
      }
      projectRoot = parent;
      attempts++;
    }
    
    // If not found, use temp directory
    if (projectRoot == null || !File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync()) {
      final tempDir = Directory.systemTemp;
      projectRoot = Directory(path.join(tempDir.path, 'android_screenshots'));
      debugPrint('Using temp directory: ${projectRoot.path}');
    }
    
    screenshotsDir = Directory(path.join(projectRoot.path, 'screenshots'));
    
    debugPrint('Project root: ${projectRoot.path}');
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
        
        testWidgets('Android ${deviceName}_${locale.languageCode}_$themeString Main screen', (tester) async {
          // Set device size
          await tester.binding.setSurfaceSize(deviceSize);
          
          await tester.pumpWidget(
            app.EvAssistApp(locale: locale, themeMode: theme),
          );
          await tester.pumpAndSettle(const Duration(seconds: 3));
          
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

        testWidgets('Android ${deviceName}_${locale.languageCode}_$themeString Settings screen', (tester) async {
          // Set device size
          await tester.binding.setSurfaceSize(deviceSize);
          
          await tester.pumpWidget(
            app.EvAssistApp(locale: locale, themeMode: theme),
          );
          await tester.pumpAndSettle(const Duration(seconds: 3));
          
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

        testWidgets('Android ${deviceName}_${locale.languageCode}_$themeString Language menu', (tester) async {
          // Set device size
          await tester.binding.setSurfaceSize(deviceSize);
          
          await tester.pumpWidget(
            app.EvAssistApp(locale: locale, themeMode: theme),
          );
          await tester.pumpAndSettle(const Duration(seconds: 3));
          
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
  await tester.pumpAndSettle(const Duration(seconds: 2));
  
  try {
    // Fill consumption fields
    await tester.enterText(find.byType(TextFormField).at(0), '18.5');
    await tester.pump(const Duration(milliseconds: 100));
    
    await tester.enterText(find.byType(TextFormField).at(1), '100');
    await tester.pump(const Duration(milliseconds: 100));
    
    // Fill destination distance
    await tester.enterText(find.byType(TextFormField).at(2), '250');
    await tester.pump(const Duration(milliseconds: 100));
    
    // Fill battery capacity
    await tester.enterText(find.byType(TextFormField).at(3), '77');
    await tester.pump(const Duration(milliseconds: 100));
    
    // Fill current battery level
    await tester.enterText(find.byType(TextFormField).at(4), '65');
    await tester.pump(const Duration(milliseconds: 100));
    
    // Fill desired battery level
    await tester.enterText(find.byType(TextFormField).at(5), '20');
    await tester.pump(const Duration(milliseconds: 100));
    
    await tester.pumpAndSettle();
    debugPrint('Sample data filled successfully');
  } catch (e) {
    debugPrint('Error filling sample data: $e');
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
    // Convert Flutter surface to image before taking screenshot
    await binding.convertFlutterSurfaceToImage();
    final bytes = await binding.takeScreenshot(fileName);
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    
    debugPrint('✅ Screenshot saved: $filePath');
  } catch (e, stackTrace) {
    debugPrint('❌ Failed to save screenshot $filePath: $e');
    debugPrint(stackTrace.toString());
  }
}