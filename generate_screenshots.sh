#!/bin/bash
# EV Assist Screenshot Generator - Shell Script

echo "🚀 EV Assist Screenshot Generator"
echo "================================="

# Check if Dart is available
if ! command -v dart &> /dev/null; then
    echo "❌ Error: Dart not found in PATH"
    echo "Please ensure Flutter SDK is installed and in your PATH"
    exit 1
fi

# Check if we're in the right directory
if [[ ! -f pubspec.yaml ]]; then
    echo "❌ Error: Must run from project root (where pubspec.yaml exists)"
    exit 1
fi

# Create scripts directory if it doesn't exist
mkdir -p scripts

# Run the Dart script with all arguments
dart scripts/generate_screenshots.dart "$@"