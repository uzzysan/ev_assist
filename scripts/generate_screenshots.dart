#!/usr/bin/env dart

import 'dart:io';

/// Script to automate screenshot generation for the EV Assist app.
/// This script handles running the integration tests and organizing the output.
void main(List<String> arguments) async {
  print('🚀 EV Assist Screenshot Generator');
  print('=' * 50);

  // Parse command line arguments
  var useEnhanced = arguments.contains('--enhanced');
  String? deviceOnly;
  String? localeOnly;
  
  try {
    deviceOnly = arguments.where((arg) => arg.startsWith('--device=')).first;
  } catch (_) {
    deviceOnly = null;
  }
  
  try {
    localeOnly = arguments.where((arg) => arg.startsWith('--locale=')).first;
  } catch (_) {
    localeOnly = null;
  }
  
  if (arguments.contains('--help') || arguments.contains('-h')) {
    _showHelp();
    return;
  }

  // Ensure we're in the project root
  final pubspecFile = File('pubspec.yaml');
  if (!await pubspecFile.exists()) {
    print('❌ Error: Must run from project root (where pubspec.yaml exists)');
    exit(1);
  }

  // Choose test file
  final testFile = useEnhanced 
      ? 'integration_test/enhanced_screenshots_test.dart'
      : 'integration_test/screenshots_test.dart';
  
  if (!await File(testFile).exists()) {
    print('❌ Error: Test file $testFile does not exist');
    exit(1);
  }

  print('📱 Using test file: $testFile');
  
  // Build filters based on arguments
  List<String> nameFilters = [];
  if (deviceOnly != null) {
    final device = deviceOnly.split('=')[1];
    nameFilters.add('--name-filter=.*${device}.*');
  }
  if (localeOnly != null) {
    final locale = localeOnly.split('=')[1];
    nameFilters.add('--name-filter=.*${locale}.*');
  }

  // Check if Flutter is available
  print('🔍 Checking Flutter availability...');
  try {
    await _runCommand('flutter', ['--version'], timeout: 10);
    print('✅ Flutter found and working');
  } catch (e) {
    print('❌ Error: Flutter not found in PATH or not working');
    print('Please ensure Flutter SDK is installed and in your PATH');
    print('You can also run the integration test directly:');
    print('  flutter test $testFile');
    exit(1);
  }

  // Clean previous build
  print('🧹 Cleaning previous build...');
  await _runCommand('flutter', ['clean']);

  // Get dependencies
  print('📦 Getting dependencies...');
  await _runCommand('flutter', ['pub', 'get']);

  // Run integration tests
  print('📸 Generating screenshots...');
  final testArgs = [
    'test',
    testFile,
    '--verbose',
    ...nameFilters,
  ];
  
  try {
    await _runCommand('flutter', testArgs);
    print('✅ Screenshots generated successfully!');
    
    if (useEnhanced) {
      await _displayResults();
    }
  } catch (e) {
    print('❌ Error generating screenshots: $e');
    exit(1);
  }
}

Future<void> _runCommand(String command, List<String> arguments, {int? timeout}) async {
  print('🔄 Running: $command ${arguments.join(' ')}');
  
  try {
    final process = await Process.start(command, arguments);
    
    // Stream output in real-time
    process.stdout.transform(SystemEncoding().decoder).listen((data) {
      stdout.write(data);
    });
    
    process.stderr.transform(SystemEncoding().decoder).listen((data) {
      stderr.write(data);
    });
    
    final exitCode = timeout != null 
        ? await process.exitCode.timeout(Duration(seconds: timeout))
        : await process.exitCode;
        
    if (exitCode != 0) {
      throw Exception('Command failed with exit code $exitCode');
    }
  } on ProcessException catch (e) {
    throw Exception('Failed to start process: ${e.message}');
  } catch (e) {
    throw Exception('Command execution failed: $e');
  }
}

Future<void> _displayResults() async {
  final screenshotsDir = Directory('screenshots');
  
  if (!await screenshotsDir.exists()) {
    print('ℹ️ No screenshots directory found');
    return;
  }

  print('\\n📊 Screenshot Summary:');
  print('=' * 30);
  
  final phoneDir = Directory('screenshots/phone');
  final tabletDir = Directory('screenshots/tablet');
  
  if (await phoneDir.exists()) {
    print('📱 Phone Screenshots:');
    await _listScreenshots(phoneDir, '  ');
  }
  
  if (await tabletDir.exists()) {
    print('\\n📟 Tablet Screenshots:');
    await _listScreenshots(tabletDir, '  ');
  }
  
  print('\\n📁 All screenshots saved in: ${screenshotsDir.absolute.path}');
}

Future<void> _listScreenshots(Directory dir, String indent) async {
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.png')) {
      final relativePath = entity.path.substring(dir.path.length + 1);
      final fileSize = await entity.length();
      final sizeKB = (fileSize / 1024).toStringAsFixed(1);
      print('$indent$relativePath (${sizeKB}KB)');
    }
  }
}

void _showHelp() {
  print('''
EV Assist Screenshot Generator

Usage: dart scripts/generate_screenshots.dart [options]

Options:
  --enhanced           Use the enhanced screenshot test (more devices & screens)
  --device=<name>      Only generate screenshots for specific device
  --locale=<code>      Only generate screenshots for specific locale
  --help, -h          Show this help message

Examples:
  dart scripts/generate_screenshots.dart --enhanced
  dart scripts/generate_screenshots.dart --device=iphone_6_7 --locale=en
  dart scripts/generate_screenshots.dart --enhanced --locale=pl

Available devices (enhanced mode):
  Phones: iphone_6_7, iphone_6_5, iphone_5_5, android_phone
  Tablets: ipad_pro_12_9, ipad_10_9, android_tablet

Available locales: en, pl, de, es, fr
''');
}