import UIKit

protocol ControllerFactory {
    func buildMainViewController() -> MainViewController
    func buildLocationsViewController() -> LocationsViewController
    func buildLocationAddingViewController() -> LocationAddingViewController
 }

final class MainControllerFactory: ControllerFactory {

    func buildMainViewController() -> MainViewController {
        return MainViewController(rootViewController: buildLocationsViewController())
    }

    func buildLocationsViewController() -> LocationsViewController {
        //TODO: Move service to dependeny container
        let viewModel = MainLocationsViewModel(locationService: MainLocationService())
        return LocationsViewController(viewModel: viewModel)
    }

    func buildLocationAddingViewController() -> LocationAddingViewController {
        return LocationAddingViewController()
    }
}
