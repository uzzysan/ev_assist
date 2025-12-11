import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ev_assist/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Quick Screenshot Test', (WidgetTester tester) async {
    // Set device size to phone
    await tester.binding.setSurfaceSize(const Size(390, 844));
    
    // Launch app
    await tester.pumpWidget(
      app.EvAssistApp(locale: const Locale('en'), themeMode: ThemeMode.light),
    );
    
    // Wait for splash screen (2 seconds) plus extra time
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Convert surface to image before taking screenshot
    await binding.convertFlutterSurfaceToImage();
    
    // Create temp directory
    final tmpDir = await Directory.systemTemp.createTemp('ev_assist_quick_');
    debugPrint('Screenshots temp dir: ${tmpDir.path}');
    
    // Take screenshot
    final bytes = await binding.takeScreenshot('quick_test');
    final filePath = '${tmpDir.path.replaceAll('\\', '/')}/quick_test.png';
    final file = File(filePath);
    
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
    debugPrint('Saved screenshot: ${file.path}');
    
    expect(file.existsSync(), true);
  });
}