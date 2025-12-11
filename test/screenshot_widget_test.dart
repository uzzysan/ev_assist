import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  group('Screenshot Tests', () {
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

      final screenshotsPath = path.join(projectRoot.path, 'screenshots');
      screenshotsDir = Directory(screenshotsPath);
      
      if (await screenshotsDir.exists()) {
        await screenshotsDir.delete(recursive: true);
      }
      await screenshotsDir.create(recursive: true);
      
      print('Screenshots will be saved to: ${screenshotsDir.path}');
    });

    // Device configurations with App Store standard sizes
    final deviceConfigs = [
      {'name': 'iphone_6_7', 'size': const Size(414, 896), 'type': 'phone'},
      {'name': 'iphone_6_5', 'size': const Size(390, 844), 'type': 'phone'},
      {'name': 'android_phone', 'size': const Size(360, 640), 'type': 'phone'},
      {'name': 'ipad_pro_12_9', 'size': const Size(1024, 1366), 'type': 'tablet'},
      {'name': 'android_tablet', 'size': const Size(800, 1280), 'type': 'tablet'},
    ];

    final locales = [
      const Locale('en'),
      const Locale('pl'),
    ];

    final themes = [
      {'mode': ThemeMode.light, 'name': 'light'},
      {'mode': ThemeMode.dark, 'name': 'dark'},
    ];

    for (final device in deviceConfigs) {
      for (final locale in locales) {
        for (final theme in themes) {
          testWidgets(
            'Screenshot ${device['name']}_${locale.languageCode}_${theme['name']}',
            (WidgetTester tester) async {
              // Set device size
              await tester.binding.setSurfaceSize(device['size'] as Size);
              
              // Create app with test-friendly configuration
              await tester.pumpWidget(
                app.EvAssistApp(
                  locale: locale,
                  themeMode: theme['mode'] as ThemeMode,
                  skipSplash: true,
                ),
              );
              
              // Wait for app to settle
              await tester.pumpAndSettle(const Duration(seconds: 3));
              
              // Try to fill sample data
              await _fillSampleData(tester);
              await tester.pumpAndSettle();

              // Take screenshot
              await _takeScreenshot(
                tester,
                screenshotsDir,
                device['name'] as String,
                device['type'] as String,
                locale.languageCode,
                theme['name'] as String,
                'main',
              );
            },
          );
        }
      }
    }
  });
}

Future<void> _fillSampleData(WidgetTester tester) async {
  try {
    final textFields = find.byType(TextFormField);
    final fieldCount = textFields.evaluate().length;
    
    if (fieldCount >= 6) {
      final sampleData = [
        '18.5', // Average consumption
        '100',  // Distance base
        '285',  // Destination distance
        '75',   // Battery capacity
        '80',   // Current battery level
        '20',   // Desired arrival level
      ];
      
      for (int i = 0; i < sampleData.length && i < fieldCount; i++) {
        await tester.enterText(textFields.at(i), sampleData[i]);
        await tester.pump(const Duration(milliseconds: 100));
      }
      
      await tester.pumpAndSettle();
      print('Sample data filled successfully');
    }
  } catch (e) {
    print('Error filling sample data: $e');
    // Continue anyway - screenshots might still be useful
  }
}

Future<void> _takeScreenshot(
  WidgetTester tester,
  Directory screenshotsDir,
  String deviceName,
  String deviceType,
  String locale,
  String theme,
  String screenName,
) async {
  try {
    // Create directory structure
    final deviceDir = Directory(path.join(screenshotsDir.path, deviceType, deviceName, theme));
    await deviceDir.create(recursive: true);
    
    final fileName = '${locale}_$screenName.png';
    final filePath = path.join(deviceDir.path, fileName);

    // Find the widget to capture
    final finder = find.byType(MaterialApp);
    expect(finder, findsOneWidget);

    // Capture screenshot
    final RenderRepaintBoundary boundary = tester.renderObject(finder) as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 1.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData != null) {
      final Uint8List bytes = byteData.buffer.asUint8List();
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      print('✅ Screenshot saved: $filePath');
    } else {
      print('❌ Failed to convert image to bytes for $filePath');
    }
    
    image.dispose();
  } catch (e, stackTrace) {
    print('❌ Failed to take screenshot for $deviceName $locale $theme: $e');
    print(stackTrace);
  }
}