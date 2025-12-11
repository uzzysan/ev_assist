import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:ev_assist/main.dart' as app;

void main() {
  group('Simple Screenshot Tests', () {
    // First, let's test just one configuration to make sure it works
    testWidgets('iPhone 6.7 English Light Theme', (WidgetTester tester) async {
      // Set screen size to iPhone
      tester.view.physicalSize = const Size(414, 896);
      tester.view.devicePixelRatio = 1.0;
      
      // Create app with test configuration
      await tester.pumpWidget(
        app.EvAssistApp(
          locale: const Locale('en'),
          themeMode: ThemeMode.light,
          skipSplash: true,
        ),
      );
      
      // Wait for everything to settle
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Try to fill some sample data quickly
      try {
        final textFields = find.byType(TextFormField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.enterText(textFields.first, '18.5');
          await tester.pump();
          
          if (textFields.evaluate().length > 2) {
            await tester.enterText(textFields.at(2), '250');
            await tester.pump();
          }
        }
      } catch (e) {
        print('Could not fill data: $e');
      }
      
      await tester.pumpAndSettle();
      
      // Use golden file test - this is much faster than manual screenshot
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden/iphone_6_7_en_light.png'),
      );
    });
    
    testWidgets('iPhone 6.7 English Dark Theme', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(414, 896);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        app.EvAssistApp(
          locale: const Locale('en'),
          themeMode: ThemeMode.dark,
          skipSplash: true,
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Fill sample data
      try {
        final textFields = find.byType(TextFormField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.enterText(textFields.first, '18.5');
          await tester.pump();
          
          if (textFields.evaluate().length > 2) {
            await tester.enterText(textFields.at(2), '250');
            await tester.pump();
          }
        }
      } catch (e) {
        print('Could not fill data: $e');
      }
      
      await tester.pumpAndSettle();
      
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden/iphone_6_7_en_dark.png'),
      );
    });

    testWidgets('iPad Pro 12.9 English Light Theme', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1024, 1366);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        app.EvAssistApp(
          locale: const Locale('en'),
          themeMode: ThemeMode.light,
          skipSplash: true,
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Fill sample data
      try {
        final textFields = find.byType(TextFormField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.enterText(textFields.first, '18.5');
          await tester.pump();
          
          if (textFields.evaluate().length > 2) {
            await tester.enterText(textFields.at(2), '250');
            await tester.pump();
          }
        }
      } catch (e) {
        print('Could not fill data: $e');
      }
      
      await tester.pumpAndSettle();
      
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden/ipad_pro_12_9_en_light.png'),
      );
    });
    
    testWidgets('iPhone 6.7 Polish Light Theme', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(414, 896);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        app.EvAssistApp(
          locale: const Locale('pl'),
          themeMode: ThemeMode.light,
          skipSplash: true,
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Fill sample data
      try {
        final textFields = find.byType(TextFormField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.enterText(textFields.first, '18,5'); // Polish uses comma
          await tester.pump();
          
          if (textFields.evaluate().length > 2) {
            await tester.enterText(textFields.at(2), '250');
            await tester.pump();
          }
        }
      } catch (e) {
        print('Could not fill data: $e');
      }
      
      await tester.pumpAndSettle();
      
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden/iphone_6_7_pl_light.png'),
      );
    });
  });
}