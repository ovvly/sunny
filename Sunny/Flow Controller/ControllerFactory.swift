import UIKit

protocol ControllerFactory {
    func buildMainViewController() -> MainViewController
    func buildLocationsViewController() -> LocationsViewController
    func buildLocationAddingViewController() -> LocationAddingViewController
    func buildWeatherViewController(with location: Location) -> WeatherViewController
 }

final class MainControllerFactory: ControllerFactory {
    private let dependencyContainer: DependencyContainer

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    func buildMainViewController() -> MainViewController {
        return MainViewController(rootViewController: buildLocationsViewController())
    }

    func buildLocationsViewController() -> LocationsViewController {
        let viewModel = MainLocationsViewModel(locationService: dependencyContainer.locationService, locationProvider: MainLocationProvider())
        return LocationsViewController(viewModel: viewModel)
    }

    func buildLocationAddingViewController() -> LocationAddingViewController {
        return LocationAddingViewController()
    }

    func buildWeatherViewController(with location: Location) -> WeatherViewController {
        let viewModel = MainWeatherViewModel(weatherService: dependencyContainer.weatherService, location: location)
        return WeatherViewController(viewModel: viewModel)
    }
}
