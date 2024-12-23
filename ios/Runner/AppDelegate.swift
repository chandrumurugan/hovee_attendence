//import UIKit
//import Flutter
//import GoogleMaps
//import flutter_local_notifications
//import Firebase
//import app_links
//
//@main
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//       GMSServices.provideAPIKey("AIzaSyCHz8A3xojD4i29cCnzD9v148AcfCa5iOE")
//       // CONFIGURE FIREBASE PROJECT
//   
//      if #available(iOS 10.0, *) {
//   UNUserNotificationCenter.current().delegate = self
// }
//     let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
//      
//       UNUserNotificationCenter.current().requestAuthorization(
//           options: authOptions,
//           completionHandler: {_,_ in })
//    
//       UNUserNotificationCenter.current().delegate = self
//       application.registerForRemoteNotifications() // here your alert with Permission will appear
//      
//
//
//          FirebaseApp.configure()
//    
//
//       GeneratedPluginRegistrant.register(with: self)
//              if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
//       // We have a link, propagate it to your Flutter app or not
//       AppLinks.shared.handleLink(url: url)
//       return true // Returning true will stop the propagation to other packages
//     }
//
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//
//
//  }
//}



import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import Firebase
import app_links

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()

        // Google Maps API Key
        GMSServices.provideAPIKey("AIzaSyCHz8A3xojD4i29cCnzD9v148AcfCa5iOE")

        // Notifications Setup
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        }
        application.registerForRemoteNotifications()

        // App Links Handling
        if let launchOptions = launchOptions,
           let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
            AppLinks.shared.handleLink(url: url)
        }

        // Plugin Registration
        GeneratedPluginRegistrant.register(with: self)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

