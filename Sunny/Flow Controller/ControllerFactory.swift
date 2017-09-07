import UIKit

protocol ControllerFactory {
    func buildLocationsViewController() -> LocationsViewController
 }

final class MainControllerFactory: ControllerFactory {
    func buildLocationsViewController() -> LocationsViewController {
        return LocationsViewController(viewModel: MainLocationsViewModel())
    }
}
