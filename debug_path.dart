import 'dart:io';

void main() {
  final projectRoot = Directory.current;
  print('Current directory: ${projectRoot.path}');
  final screenshotsPath = '${projectRoot.path}/screenshots';
  print('Screenshots path: $screenshotsPath');
}