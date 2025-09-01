# EV Assist Screenshot Generator - PowerShell Script
param(
    [switch]$Enhanced,
    [string]$Device,
    [string]$Locale,
    [switch]$Help
)

Write-Host "🚀 EV Assist Screenshot Generator" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""

if ($Help) {
    Write-Host @"
EV Assist Screenshot Generator

Usage: .\generate_screenshots.ps1 [options]

Options:
  -Enhanced           Use the enhanced screenshot test (more devices & screens)
  -Device <name>      Only generate screenshots for specific device
  -Locale <code>      Only generate screenshots for specific locale
  -Help              Show this help message

Examples:
  .\generate_screenshots.ps1 -Enhanced
  .\generate_screenshots.ps1 -Device iphone_6_7 -Locale en
  .\generate_screenshots.ps1 -Enhanced -Locale pl

Available devices (enhanced mode):
  Phones: iphone_6_7, iphone_6_5, iphone_5_5, android_phone
  Tablets: ipad_pro_12_9, ipad_10_9, android_tablet

Available locales: en, pl, de, es, fr
"@
    return
}

# Check if Dart is available
try {
    dart --version | Out-Null
    Write-Host "✅ Dart found in PATH" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Dart not found in PATH" -ForegroundColor Red
    Write-Host "Please ensure Flutter SDK is installed and in your PATH" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if we're in the right directory
if (-not (Test-Path "pubspec.yaml")) {
    Write-Host "❌ Error: Must run from project root where pubspec.yaml exists" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✅ Found pubspec.yaml" -ForegroundColor Green

# Check if scripts directory exists
if (-not (Test-Path "scripts")) {
    New-Item -ItemType Directory -Name "scripts" | Out-Null
    Write-Host "📁 Created scripts directory" -ForegroundColor Yellow
}

# Check if the Dart script exists
if (-not (Test-Path "scripts\generate_screenshots.dart")) {
    Write-Host "❌ Error: scripts\generate_screenshots.dart not found" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✅ Found Dart script" -ForegroundColor Green

# Build arguments
$dartArgs = @("scripts\generate_screenshots.dart")

if ($Enhanced) {
    $dartArgs += "--enhanced"
}

if ($Device) {
    $dartArgs += "--device=$Device"
}

if ($Locale) {
    $dartArgs += "--locale=$Locale"
}

# Show what we're about to run
Write-Host "🔄 Running: dart $($dartArgs -join ' ')" -ForegroundColor Cyan
Write-Host ""

# Run the Dart script
try {
    & dart @dartArgs
    $exitCode = $LASTEXITCODE
    
    Write-Host ""
    if ($exitCode -eq 0) {
        Write-Host "✅ Screenshot generation completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Screenshot generation failed with exit code $exitCode" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Error running Dart script: $_" -ForegroundColor Red
    $exitCode = 1
}

Write-Host ""
Read-Host "Press Enter to exit"
exit $exitCode