import Firebase
import UIKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        // Window setup
        
        // Testing storyboard Profile
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let testboard = UIStoryboard(name: "Profile", bundle: nil)
        window?.rootViewController = testboard.instantiateViewController(withIdentifier: "TestStoryboard")
//        window?.rootViewController = UINavigationController(rootViewController: ATCClassicLandingScreenViewController(nibName: "ATCClassicLandingScreenViewController", bundle: nil))
        window?.makeKeyAndVisible()
        return true
    }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      return ApplicationDelegate.shared.application(app, open: url, options: options)
  }
    
}

