import Foundation
import RxSwift

protocol WeatherService {
    func weather(for location: Location) -> Observable<Weather>
}

class MainWeatherService: WeatherService {
    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func weather(for location: Location) -> Observable<Weather> {
        return client.request(Weather.current(in: location))
    }
}
