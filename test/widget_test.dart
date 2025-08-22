// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:provider/provider.dart';

import 'package:ev_assist/main.dart';

void main() {
  testWidgets('EvAssistApp displays main UI elements', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: const EvAssistApp(),
      ),
    );

    // Sprawdź tytuł aplikacji (z lokalizacji)
    expect(find.text('EV Charging Assistant'), findsOneWidget);
    // lub polska wersja
    // expect(find.text('Asystent ładowania EV'), findsOneWidget);

    // Sprawdź przycisk "Oblicz" lub "Calculate"
    final hasPolishButton = find
        .widgetWithText(ElevatedButton, 'Oblicz')
        .evaluate()
        .isNotEmpty;
    final hasEnglishButton = find
        .widgetWithText(ElevatedButton, 'Calculate')
        .evaluate()
        .isNotEmpty;
    expect(hasPolishButton || hasEnglishButton, true);

    // Sprawdź obecność banera reklamowego
    expect(find.byType(AdBannerWidget), findsOneWidget);

    // Sprawdź obecność pól tekstowych
    expect(find.byType(TextFormField), findsWidgets);
  });
}
