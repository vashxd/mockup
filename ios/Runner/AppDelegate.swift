import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Configurando a aparência da barra de status
    UIApplication.shared.statusBarStyle = .lightContent
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
