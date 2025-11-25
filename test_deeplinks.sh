#!/bin/bash

# Deep Link Testing Script for StayPoint App
# Usage: ./test_deeplinks.sh [android|ios] [hotels|favorites]

PLATFORM=${1:-android}
TAB=${2:-hotels}

# Update this with your actual package name from android/app/build.gradle.kts
PACKAGE_NAME="com.example.checklist_app"
DEEPLINK_BASE="hotelbooking://"

if [ "$TAB" = "hotels" ]; then
    DEEPLINK="${DEEPLINK_BASE}hotels"
elif [ "$TAB" = "favorites" ]; then
    DEEPLINK="${DEEPLINK_BASE}favorites"
else
    echo "Invalid tab. Use 'hotels' or 'favorites'"
    exit 1
fi

echo "Testing deep link: $DEEPLINK"
echo "Platform: $PLATFORM"
echo ""

if [ "$PLATFORM" = "android" ]; then
    echo "Opening deep link on Android..."
    adb shell am start -W -a android.intent.action.VIEW -d "$DEEPLINK" "$PACKAGE_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ Deep link sent successfully!"
    else
        echo "✗ Failed to send deep link. Make sure:"
        echo "  1. Device/emulator is connected"
        echo "  2. App is installed"
        echo "  3. Package name is correct: $PACKAGE_NAME"
    fi
elif [ "$PLATFORM" = "ios" ]; then
    echo "Opening deep link on iOS Simulator..."
    xcrun simctl openurl booted "$DEEPLINK"
    
    if [ $? -eq 0 ]; then
        echo "✓ Deep link sent successfully!"
    else
        echo "✗ Failed to send deep link. Make sure:"
        echo "  1. iOS Simulator is running"
        echo "  2. App is installed on simulator"
    fi
else
    echo "Invalid platform. Use 'android' or 'ios'"
    exit 1
fi

