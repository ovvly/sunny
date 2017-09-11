import UIKit

protocol FlowController {
    func buildMainWindow() -> UIWindow
}

final class MainFlowController: FlowController {
    fileprivate let controllerFactory: ControllerFactory
    fileprivate let dependencyContainer: DependencyContainer

    fileprivate lazy var mainViewController: UIViewController = {
        let mainController = self.controllerFactory.buildMainViewController()
        mainController.locationsViewController.delegate = self
        return mainController
    }()

    init(dependencyContainer: DependencyContainer, controllerFactory: ControllerFactory = MainControllerFactory()) {
        self.dependencyContainer = dependencyContainer
        self.controllerFactory = controllerFactory
    }

    func buildMainWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = mainViewController

        return window
    }
}

extension MainFlowController: LocationsViewControllerDelegate {
    func viewControllerDidAdd(_ viewController: LocationsViewController) {
        let locationAddingViewController = controllerFactory.buildLocationAddingViewController()
        locationAddingViewController.delegate = self
        viewController.modalPresentationStyle = .formSheet
        viewController.present(locationAddingViewController, animated: true)
    }
}

extension MainFlowController: LocationAddingViewControllerDelegate {
    func viewController(_ viewController: LocationAddingViewController, didAdd location: Location) {
        let locationsNavigationController = viewController.presentingViewController as! UINavigationController
        let locationsViewController = locationsNavigationController.viewControllers.first as! LocationsViewController
        locationsViewController.added(location: location)

        viewController.dismiss(animated: true)
    }
}
