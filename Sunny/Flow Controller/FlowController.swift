import UIKit

protocol FlowController {
    func buildMainWindow() -> UIWindow
}

final class MainFlowController: FlowController {
    fileprivate let controllerFactory: ControllerFactory

    fileprivate lazy var mainViewController: UIViewController = {
        let mainController = self.controllerFactory.buildMainViewController()
        mainController.locationsViewController.delegate = self
        return mainController
    }()

    convenience init(dependencyContainer: DependencyContainer) {
        let controllerFactory = MainControllerFactory(dependencyContainer: dependencyContainer)
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

extension MainFlowController: LocationsViewControllerDelegate {
    func viewControllerDidAdd(_ viewController: LocationsViewController) {
        let locationAddingViewController = controllerFactory.buildLocationAddingViewController()
        locationAddingViewController.delegate = self
        viewController.navigationController?.pushViewController(locationAddingViewController, animated: true)
    }

    func viewController(_ viewController: LocationsViewController, selected location: Location) {
        let weatherViewController = controllerFactory.buildWeatherViewController(with: location)
        viewController.navigationController?.pushViewController(weatherViewController, animated: true)
    }
}

extension MainFlowController: LocationAddingViewControllerDelegate {
    func viewController(_ viewController: LocationAddingViewController, didAdd location: Location) {
        if let locationsViewController = viewController.navigationController?.viewControllers.first as? LocationsViewController {
            locationsViewController.added(location: location)
        }

        _ = viewController.navigationController?.popViewController(animated: true)
    }
}
