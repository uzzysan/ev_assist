import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
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
    final projectRoot = Directory.current;
    screenshotsDir = Directory('${projectRoot.path}/screenshots');
    
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
  // Fill consumption fields
  final consumptionField = find.byType(TextFormField).first;
  await tester.enterText(consumptionField, '18.5');
  
  final distanceField = find.byType(TextFormField).at(1);
  await tester.enterText(distanceField, '100');
  
  // Fill destination distance
  final destinationField = find.byType(TextFormField).at(2);
  await tester.enterText(destinationField, '250');
  
  // Fill battery capacity
  final capacityField = find.byType(TextFormField).at(3);
  await tester.enterText(capacityField, '77');
  
  // Fill current battery level
  final currentLevelField = find.byType(TextFormField).at(4);
  await tester.enterText(currentLevelField, '65');
  
  // Fill desired battery level
  final desiredLevelField = find.byType(TextFormField).at(5);
  await tester.enterText(desiredLevelField, '20');
  
  await tester.pumpAndSettle();
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
  final deviceDir = Directory('${screenshotsDir.path}/$deviceType/$deviceName/$theme');
  await deviceDir.create(recursive: true);
  
  final fileName = '${locale}_$screenName.png';
  final filePath = '${deviceDir.path}/$fileName';
  
  try {
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