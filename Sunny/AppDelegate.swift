import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var dependencyContainer: DependencyContainer = MainDependencyContainer()
    lazy var flowController: FlowController = {
        return MainFlowController(dependencyContainer: self.dependencyContainer)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = flowController.buildMainWindow()
        window?.makeKeyAndVisible()

        return true
    }
}

