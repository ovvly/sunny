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
        if let coordinates = location.coordinates {
            return client.request(Weather.current(at: coordinates))
        } else {
            return client.request(Weather.current(at: location))
        }
    }
}
