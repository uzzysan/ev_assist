# Screenshot Generation System

This project includes an automated screenshot generation system for creating App Store screenshots across multiple devices, themes, and locales.

## Quick Start

### Windows
```bash
generate_screenshots.bat --enhanced
```

### Linux/macOS
```bash
./generate_screenshots.sh --enhanced
```

## Features

### 📱 Device Support
- **Phones**: iPhone 6.7", iPhone 6.5", iPhone 5.5", Android phones
- **Tablets**: iPad Pro 12.9", iPad 10.9", Android tablets
- Realistic App Store screenshot dimensions

### 🎨 Theme Support
- Light theme
- Dark theme
- Automatic theme switching per variant

### 🌍 Multi-language Support
- English (en)
- Polish (pl) 
- German (de)
- Spanish (es)
- French (fr)

### 📸 Multiple Screen Captures
- Main screen with sample data
- Settings screen
- Language selection menu

## Usage

### Basic Usage
```bash
# Generate all screenshots (original simple version)
dart scripts/generate_screenshots.dart

# Generate enhanced screenshots (recommended)
dart scripts/generate_screenshots.dart --enhanced
```

### Filtered Generation
```bash
# Only iPhone screenshots
dart scripts/generate_screenshots.dart --enhanced --device=iphone_6_7

# Only Polish language
dart scripts/generate_screenshots.dart --enhanced --locale=pl

# Specific device and language
dart scripts/generate_screenshots.dart --enhanced --device=ipad_pro_12_9 --locale=en
```

### Available Options
- `--enhanced` - Use enhanced test with more devices and screens
- `--device=<name>` - Generate for specific device only
- `--locale=<code>` - Generate for specific language only
- `--help` - Show help message

## Output Structure

Screenshots are organized in a clear directory structure:

```
screenshots/
├── phone/
│   ├── iphone_6_7/
│   │   ├── light/
│   │   │   ├── en_main.png
│   │   │   ├── en_settings.png
│   │   │   └── en_language_menu.png
│   │   └── dark/
│   │       ├── en_main.png
│   │       ├── en_settings.png
│   │       └── en_language_menu.png
│   └── android_phone/
│       └── ...
└── tablet/
    ├── ipad_pro_12_9/
    │   ├── light/
    │   └── dark/
    └── android_tablet/
        └── ...
```

## Device Specifications

### Phone Sizes
- `iphone_6_7`: 414×896 (iPhone 11, 12, 13, 14)
- `iphone_6_5`: 390×844 (iPhone 12 Pro, 13 Pro, 14 Pro)  
- `iphone_5_5`: 375×667 (iPhone SE 3rd gen)
- `android_phone`: 360×640 (Standard Android)

### Tablet Sizes
- `ipad_pro_12_9`: 1024×1366 (iPad Pro 12.9")
- `ipad_10_9`: 834×1194 (iPad Air, iPad Pro 11")
- `android_tablet`: 800×1280 (Standard Android tablet)

## Sample Data

The enhanced screenshot system automatically fills in realistic sample data:
- Average consumption: 18.5 kWh/100km
- Distance for consumption calculation: 100 km
- Destination distance: 250 km
- Battery capacity: 77 kWh
- Current battery level: 65%
- Desired arrival level: 20%

## Troubleshooting

### Prerequisites
- Flutter SDK installed and in PATH
- Project dependencies installed (`flutter pub get`)
- Integration test dependencies available

### Common Issues

**"Dart not found in PATH"**
- Ensure Flutter SDK is properly installed
- Add Flutter bin directory to your system PATH

**"Must run from project root"**
- Navigate to the project directory containing `pubspec.yaml`
- Run the script from there

**Test failures**
- Clean the project: `flutter clean`
- Get dependencies: `flutter pub get`
- Ensure no emulators are running that might conflict

### Performance Tips
- Use `--device` or `--locale` filters for faster generation
- Close other applications to free up memory
- Use SSD storage for faster file I/O

## Customization

### Adding New Devices
Edit `integration_test/enhanced_screenshots_test.dart`:
```dart
final Map<String, Size> deviceSizes = {
  'custom_device': const Size(width, height),
  // ... existing devices
};
```

### Adding New Languages
Add locales to the `locales` list:
```dart
final List<Locale> locales = [
  const Locale('your_language_code'),
  // ... existing locales
];
```

### Adding New Screens
Create new test cases in the enhanced test file following the existing pattern.

## Integration with App Store

The generated screenshots are sized for direct upload to:
- Apple App Store Connect
- Google Play Console

Choose the appropriate device sizes based on your target stores' requirements.