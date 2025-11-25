#!/bin/bash

# Flutter Checklist App - Release Build Script
echo "🏗️ Building Flutter Checklist App for Release..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Build for Android APK
echo "📱 Building Android APK..."
flutter build apk --release

# Build for Web
echo "🌐 Building for Web..."
flutter build web --release

echo "✅ Build completed! Check the build/ directory for outputs."
