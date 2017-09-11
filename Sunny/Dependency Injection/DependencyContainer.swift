import Foundation

protocol DependencyContainer {
    var locationService: LocationService { get }
    var weatherService: WeatherService { get }

}

final class MainDependencyContainer: DependencyContainer {
    private let apiClient = MainAPIClient(baseURL: AppConfiguration.baseUrl)

    lazy var locationService: LocationService = {
        return MainLocationService()
    }()

    lazy var weatherService: WeatherService = {
        return MainWeatherService(client: self.apiClient)
    }()
}
