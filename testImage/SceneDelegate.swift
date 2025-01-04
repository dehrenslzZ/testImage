import UIKit
 
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = (scene as? UIWindowScene) {
            
            let viewController = OnboardingController()
            
            let navigationController = UINavigationController(rootViewController: viewController)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}
