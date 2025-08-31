import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:screenshot/screenshot.dart';
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

  for (final variant in variants) {
    testWidgets('Screenshot ${variant['name']}', (WidgetTester tester) async {
      final controller = ScreenshotController();
      await tester.binding.setSurfaceSize(variant['device']);
      await tester.pumpWidget(
        Screenshot(
          controller: controller,
          child: app.EvAssistApp(
            locale: variant['locale'],
            themeMode: variant['theme'],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Utwórz katalog, jeśli nie istnieje
      final directory = Directory('screenshots');
      if (!await directory.exists()) {
        await directory.create();
      }

      await controller.captureAndSave(
        'screenshots',
        fileName: '${variant['name']}.png',
      );
    });
  }
}
