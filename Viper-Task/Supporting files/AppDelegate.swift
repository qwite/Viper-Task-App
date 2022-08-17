import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var mainWindow: UIWindow?
    private var router = ListCoordinator().strongRouter
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        router.setRoot(for: window)
        
        self.mainWindow = window
                
        return true
    }
}

