import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "app.channel.deeplink", binaryMessenger: controller.binaryMessenger)
    
    if let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL {
      channel.invokeMethod("getInitialLink", arguments: url.absoluteString)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "app.channel.deeplink", binaryMessenger: controller.binaryMessenger)
    channel.invokeMethod("onNewLink", arguments: url.absoluteString)
    return true
  }
}
