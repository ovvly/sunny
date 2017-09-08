import UIKit

protocol ControllerFactory {
    func buildLocationsViewController() -> LocationsViewController
 }

final class MainControllerFactory: ControllerFactory {
    func buildLocationsViewController() -> LocationsViewController {
        //TODO: Move service to dependeny container
        let viewModel = MainLocationsViewModel(locationService: PlistLocationService())
        return LocationsViewController(viewModel: viewModel)
    }
}
