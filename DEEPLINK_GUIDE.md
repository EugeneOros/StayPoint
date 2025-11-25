# Deep Link Guide

This guide explains how to generate and test deep links for the StayPoint App.

## Deep Link URLs

The app supports the following deep links:

- **Hotels Tab**: `hotelbooking://hotels`
- **Favorites Tab**: `hotelbooking://favorites`

## Testing Deep Links

### Android

#### Using ADB (Android Debug Bridge)

1. **Connect your device or start an emulator**
2. **Install the app** (if not already installed)
3. **Run the following commands:**

```bash
# Navigate to hotels tab
adb shell am start -W -a android.intent.action.VIEW -d "hotelbooking://hotels" com.staypoint.app

# Navigate to favorites tab
adb shell am start -W -a android.intent.action.VIEW -d "hotelbooking://favorites" com.staypoint.app
```

**Note:** Replace `com.staypoint.app` with your actual package name if different.

#### Using Android Studio

1. Open **Run** → **Edit Configurations**
2. Select your app configuration
3. In **Launch Options**, select **URL**
4. Enter: `hotelbooking://hotels` or `hotelbooking://favorites`
5. Run the app

#### From Browser or Other Apps

You can create an HTML file with links:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Deep Link Test</title>
</head>
<body>
    <h1>StayPoint Deep Links</h1>
    <a href="hotelbooking://hotels">Open Hotels Tab</a><br><br>
    <a href="hotelbooking://favorites">Open Favorites Tab</a>
</body>
</html>
```

Open this HTML file in a browser on your Android device and click the links.

### iOS

#### Using Simulator (xcrun simctl)

```bash
# Navigate to hotels tab
xcrun simctl openurl booted "hotelbooking://hotels"

# Navigate to favorites tab
xcrun simctl openurl booted "hotelbooking://favorites"
```

#### Using Safari on Simulator/Device

1. Open Safari on your iOS device/simulator
2. Type in the address bar: `hotelbooking://hotels` or `hotelbooking://favorites`
3. Press Enter
4. The app should open and navigate to the specified tab

#### Using Notes App

1. Create a new note in the Notes app
2. Type: `hotelbooking://hotels` or `hotelbooking://favorites`
3. Tap on the link
4. The app should open

#### From Xcode

1. In Xcode, go to **Product** → **Scheme** → **Edit Scheme**
2. Select **Run** → **Options**
3. Under **App Launch**, select **Wait for executable to be launched**
4. Or use the URL scheme in the launch arguments

## Generating Deep Links Programmatically

### From Another Flutter App

```dart
import 'package:url_launcher/url_launcher.dart';

// Navigate to hotels
await launchUrl(Uri.parse('hotelbooking://hotels'));

// Navigate to favorites
await launchUrl(Uri.parse('hotelbooking://favorites'));
```

### From Native Android (Kotlin/Java)

```kotlin
val intent = Intent(Intent.ACTION_VIEW, Uri.parse("hotelbooking://hotels"))
startActivity(intent)
```

### From Native iOS (Swift)

```swift
if let url = URL(string: "hotelbooking://hotels") {
    UIApplication.shared.open(url)
}
```

## Testing Checklist

- [ ] Test deep link when app is closed (cold start)
- [ ] Test deep link when app is in background (warm start)
- [ ] Test deep link when app is already open (hot start)
- [ ] Test invalid deep links (should not crash)
- [ ] Test deep links from browser
- [ ] Test deep links from other apps

## Troubleshooting

### Android Issues

**Problem:** Deep link doesn't work
- **Solution:** Check that `launchMode="singleTop"` is set in AndroidManifest.xml
- **Solution:** Verify intent filters are correctly configured
- **Solution:** Ensure the app is installed and the package name matches

**Problem:** App opens but doesn't navigate to correct tab
- **Solution:** Check that MainActivity.kt is correctly handling the deep link
- **Solution:** Verify the MethodChannel name matches (`app.channel.deeplink`)

### iOS Issues

**Problem:** Deep link doesn't work
- **Solution:** Check that Info.plist has the correct URL scheme configuration
- **Solution:** Verify AppDelegate.swift is handling the deep link correctly
- **Solution:** Ensure the app is installed on the device/simulator

**Problem:** "Cannot open URL" error
- **Solution:** Check that the URL scheme matches exactly: `hotelbooking://`
- **Solution:** Verify the host matches: `hotels` or `favorites`

## Advanced: Universal Links (Future Enhancement)

For production apps, consider implementing Universal Links (iOS) and App Links (Android) which work with HTTPS URLs:

- iOS Universal Links: `https://yourdomain.com/hotels`
- Android App Links: `https://yourdomain.com/favorites`

These require server configuration and are more complex but provide better user experience.

