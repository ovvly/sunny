import UIKit

protocol FlowController {
    func buildMainWindow() -> UIWindow
}

final class MainFlowController: FlowController {
    fileprivate let controllerFactory: ControllerFactory

    fileprivate lazy var mainViewController: UIViewController = {
        let mainController = self.controllerFactory.buildLocationsViewController()
        return mainController
    }()

    convenience init() {
        let controllerFactory = MainControllerFactory()
        self.init(controllerFactory: controllerFactory)
    }

    init(controllerFactory: ControllerFactory) {
        self.controllerFactory = controllerFactory
    }

    func buildMainWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = mainViewController

        return window
    }
}
