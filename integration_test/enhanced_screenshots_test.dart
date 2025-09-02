import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Device configurations with realistic App Store sizes
  final Map<String, Size> deviceSizes = {
    // Phone sizes (App Store screenshot sizes)
    'iphone_6_7': const Size(414, 896), // iPhone 11, 12, 13, 14
    'iphone_6_5': const Size(390, 844), // iPhone 12 Pro, 13 Pro, 14 Pro
    'iphone_5_5': const Size(375, 667), // iPhone SE (3rd gen)
    'android_phone': const Size(360, 640), // Standard Android phone
    
    // Tablet sizes (App Store screenshot sizes)
    'ipad_pro_12_9': const Size(1024, 1366), // iPad Pro 12.9"
    'ipad_10_9': const Size(834, 1194), // iPad Air, iPad Pro 11"
    'android_tablet': const Size(800, 1280), // Standard Android tablet
  };

  // Languages to test
  final List<Locale> locales = [
    const Locale('en'),
    const Locale('pl'),
    const Locale('de'),
    const Locale('es'),
    const Locale('fr'),
  ];

  // Themes to test
  final List<ThemeMode> themes = [
    ThemeMode.light,
    ThemeMode.dark,
  ];

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Create screenshots directory in project root
  late Directory screenshotsDir;
  
  setUpAll(() async {
    // Note: Cannot modify Platform.environment directly, but our app checks
    // for FLUTTER_TEST or INTEGRATION_TEST in Platform.environment which might
    // be set by the test framework
    
    // For integration tests, use a more reliable approach
    // Check for environment variable first, then try to find project root
    final envProjectRoot = Platform.environment['FLUTTER_PROJECT_ROOT'];
    Directory? projectRoot;
    
    if (envProjectRoot != null) {
      projectRoot = Directory(envProjectRoot);
    } else {
      // Try to find project root by looking for pubspec.yaml
      projectRoot = Directory.current;
      var attempts = 0;
      while (projectRoot != null && 
             !File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync() && 
             attempts < 10) {
        final parent = projectRoot.parent;
        if (parent.path == projectRoot.path) {
          // Reached filesystem root
          break;
        }
        projectRoot = parent;
        attempts++;
      }
    }
    
    // If still not found, use a temp directory but with better naming
    if (projectRoot == null || !File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync()) {
      final tempDir = Directory.systemTemp;
      projectRoot = Directory(path.join(tempDir.path, 'ev_assist_screenshots'));
      debugPrint('Using temp directory for screenshots: ${projectRoot.path}');
    }
    
    debugPrint('Project root: ${projectRoot.path}');
    
    final screenshotsPath = path.join(projectRoot.path, 'screenshots');
    screenshotsDir = Directory(screenshotsPath);
    debugPrint('Screenshots directory path: ${screenshotsDir.path}');
    
    if (await screenshotsDir.exists()) {
      await screenshotsDir.delete(recursive: true);
    }
    await screenshotsDir.create(recursive: true);
    
    debugPrint('Screenshots will be saved to: ${screenshotsDir.path}');
  });

  for (final deviceName in deviceSizes.keys) {
    final deviceSize = deviceSizes[deviceName]!;
    final isTablet = deviceName.contains('ipad') || deviceName.contains('tablet');
    
    for (final locale in locales) {
      for (final theme in themes) {
        final themeName = theme == ThemeMode.light ? 'light' : 'dark';
        final testName = '${deviceName}_${locale.languageCode}_$themeName';
        
        group('Screenshots for $testName', () {
          testWidgets('Main screen - $testName', (WidgetTester tester) async {
            await tester.binding.setSurfaceSize(deviceSize);
            
            // Launch app with specific locale and theme
            await tester.pumpWidget(
              app.EvAssistApp(locale: locale, themeMode: theme),
            );
            await tester.pumpAndSettle(const Duration(seconds: 2));
            
            // Fill in some sample data to make screenshots more meaningful
            await _fillSampleData(tester);
            await tester.pumpAndSettle();
            
            await _takeScreenshot(
              binding, 
              screenshotsDir, 
              deviceName, 
              locale.languageCode, 
              themeName, 
              'main',
              isTablet
            );
          });

          testWidgets('Settings screen - $testName', (WidgetTester tester) async {
            await tester.binding.setSurfaceSize(deviceSize);
            
            await tester.pumpWidget(
              app.EvAssistApp(locale: locale, themeMode: theme),
            );
            await tester.pumpAndSettle(const Duration(seconds: 2));
            
            // Navigate to settings
            await tester.tap(find.byIcon(Icons.settings));
            await tester.pumpAndSettle();
            
            await _takeScreenshot(
              binding, 
              screenshotsDir, 
              deviceName, 
              locale.languageCode, 
              themeName, 
              'settings',
              isTablet
            );
          });

          testWidgets('Language menu - $testName', (WidgetTester tester) async {
            await tester.binding.setSurfaceSize(deviceSize);
            
            await tester.pumpWidget(
              app.EvAssistApp(locale: locale, themeMode: theme),
            );
            await tester.pumpAndSettle(const Duration(seconds: 2));
            
            // Open language menu
            await tester.tap(find.byIcon(Icons.language));
            await tester.pumpAndSettle();
            
            await _takeScreenshot(
              binding, 
              screenshotsDir, 
              deviceName, 
              locale.languageCode, 
              themeName, 
              'language_menu',
              isTablet
            );
          });
        });
      }
    }
  }
}

Future<void> _fillSampleData(WidgetTester tester) async {
  // Wait for text fields to be available (wait for splash screen to finish)
  await tester.pumpAndSettle(const Duration(seconds: 3));
  
  // Check if TextFormFields are available
  final textFields = find.byType(TextFormField);
  if (textFields.evaluate().length < 6) {
    debugPrint('Warning: Expected 6 text fields, found ${textFields.evaluate().length}');
    // Pump again to make sure everything is loaded
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }
  
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
    // Continue anyway - screenshots might still be useful
  }
}

Future<void> _takeScreenshot(
  IntegrationTestWidgetsFlutterBinding binding,
  Directory screenshotsDir,
  String deviceName,
  String locale,
  String theme,
  String screenName,
  bool isTablet,
) async {
  final deviceType = isTablet ? 'tablet' : 'phone';
  
  // Create organized directory structure: screenshots/device_type/device/theme/
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
    rethrow;
  }
}