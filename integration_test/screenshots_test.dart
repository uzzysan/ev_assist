import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ev_assist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final List<Map<String, dynamic>> variants = [
    {
      'locale': const Locale('en'),
      'theme': ThemeMode.light,
      'device': const Size(390, 844), // iPhone 13
      'name': 'en_light_phone',
    },
    {
      'locale': const Locale('en'),
      'theme': ThemeMode.dark,
      'device': const Size(390, 844),
      'name': 'en_dark_phone',
    },
    {
      'locale': const Locale('pl'),
      'theme': ThemeMode.light,
      'device': const Size(390, 844),
      'name': 'pl_light_phone',
    },
    {
      'locale': const Locale('pl'),
      'theme': ThemeMode.dark,
      'device': const Size(390, 844),
      'name': 'pl_dark_phone',
    },
    {
      'locale': const Locale('en'),
      'theme': ThemeMode.light,
      'device': const Size(1280, 800), // typowy tablet
      'name': 'en_light_tablet',
    },
    {
      'locale': const Locale('en'),
      'theme': ThemeMode.dark,
      'device': const Size(1280, 800),
      'name': 'en_dark_tablet',
    },
    {
      'locale': const Locale('pl'),
      'theme': ThemeMode.light,
      'device': const Size(1280, 800),
      'name': 'pl_light_tablet',
    },
    {
      'locale': const Locale('pl'),
      'theme': ThemeMode.dark,
      'device': const Size(1280, 800),
      'name': 'pl_dark_tablet',
    },
  ];

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  for (final variant in variants) {
    testWidgets('Screenshot ${variant['name']}', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(variant['device']);
      await tester.pumpWidget(
        app.EvAssistApp(locale: variant['locale'], themeMode: variant['theme']),
      );
      await tester.pumpAndSettle();

      // Save screenshot into system temp directory (writable on device/emulator)
      final tmpDir = await Directory.systemTemp.createTemp(
        'ev_assist_screenshots_',
      );
      debugPrint('Screenshots temp dir: ${tmpDir.path}');
      // Take screenshot
      final bytes = await binding.takeScreenshot(variant['name']);
      final filePath =
          '${tmpDir.path.replaceAll('\\', '/')}/${variant['name']}.png';
      final file = File(filePath);
      try {
        await file.create(recursive: true);
        await file.writeAsBytes(bytes);
        debugPrint('Saved screenshot: ${file.path}');
      } catch (e, st) {
        debugPrint('Failed to save screenshot to ${file.path}: $e');
        debugPrint(st.toString());
        rethrow;
      }
    });
  }
}
