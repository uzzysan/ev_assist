import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Device configurations with App Store standard sizes
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

  // Languages to test (focusing on main ones for app store)
  final List<Locale> locales = [
    const Locale('en'), // English (primary)
    const Locale('pl'), // Polish (secondary)
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
    // Find project root by looking for pubspec.yaml
    Directory projectRoot = Directory.current;
    var attempts = 0;
    while (projectRoot.path != projectRoot.parent.path && attempts < 10) {
      if (File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync()) {
        break;
      }
      projectRoot = projectRoot.parent;
      attempts++;
    }
    
    if (!File(path.join(projectRoot.path, 'pubspec.yaml')).existsSync()) {
      projectRoot = Directory.current;
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
            
            // Launch app with specific locale and theme, skipping splash
            await tester.pumpWidget(
              app.EvAssistApp(
                locale: locale, 
                themeMode: theme,
                skipSplash: true, // Skip splash screen for screenshots
              ),
            );
            await tester.pumpAndSettle(const Duration(seconds: 3));
            
            // Fill in some sample data to make screenshots more meaningful
            await _fillSampleData(tester);
            await tester.pumpAndSettle(const Duration(seconds: 1));
            
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
              app.EvAssistApp(
                locale: locale, 
                themeMode: theme,
                skipSplash: true, // Skip splash screen
              ),
            );
            await tester.pumpAndSettle(const Duration(seconds: 2));
            
            // Navigate to settings
            try {
              final settingsButton = find.byIcon(Icons.settings);
              if (settingsButton.evaluate().isNotEmpty) {
                await tester.tap(settingsButton);
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
              } else {
                debugPrint('Settings button not found, skipping settings screenshot for $testName');
              }
            } catch (e) {
              debugPrint('Error navigating to settings for $testName: $e');
            }
          });
        });
      }
    }
  }
}

Future<void> _fillSampleData(WidgetTester tester) async {
  // Wait for UI to be ready
  await tester.pumpAndSettle(const Duration(seconds: 2));
  
  // Find all TextFormFields
  final textFields = find.byType(TextFormField);
  final fieldCount = textFields.evaluate().length;
  debugPrint('Found $fieldCount text fields');
  
  if (fieldCount < 6) {
    debugPrint('Warning: Expected at least 6 text fields, found $fieldCount');
    return;
  }
  
  try {
    // Sample data for EV calculation
    final sampleData = [
      '18.5',  // Average consumption (kWh/100km)
      '100',   // Distance for consumption measurement
      '285',   // Destination distance
      '75',    // Battery capacity
      '80',    // Current battery level
      '20',    // Desired arrival level
    ];
    
    for (int i = 0; i < sampleData.length && i < fieldCount; i++) {
      await tester.enterText(textFields.at(i), sampleData[i]);
      await tester.pump(const Duration(milliseconds: 100));
    }
    
    await tester.pumpAndSettle();
    debugPrint('Sample data filled successfully');
  } catch (e) {
    debugPrint('Error filling sample data: $e');
    // Continue anyway - screenshots might still be useful without data
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