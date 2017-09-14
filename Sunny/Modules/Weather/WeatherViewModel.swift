import Foundation
import RxSwift

protocol WeatherViewModel {
    var temperature: Observable<String> { get }
    var humidity: Observable<String> { get }
    var pressure: Observable<String> { get }
    var tempMin: Observable<String> { get }
    var tempMax: Observable<String> { get }
    func fetchWeather()
}

class MainWeatherViewModel: WeatherViewModel {
    let temperature: Observable<String>
    let humidity: Observable<String>
    let pressure: Observable<String>
    let tempMin: Observable<String>
    let tempMax: Observable<String>

    private let fetchTrigger = PublishSubject<Void>()

    init(weatherService: WeatherService, location: Location) {

        let weather = fetchTrigger.flatMapFirst {
            weatherService.weather(for: location)
        }.share()

        temperature = weather.map { $0.temperature.stringValue + " °F" }
        humidity = weather.map { $0.humidity.stringValue + " %" }
        pressure = weather.map { $0.pressure.stringValue + " hpa" }
        tempMin = weather.map { $0.tempMin.stringValue + " °F" }
        tempMax = weather.map { $0.tempMax.stringValue + " °F" }
    }

    func fetchWeather() {
        fetchTrigger.onNext(())
    }
}

private extension Double {
    var stringValue: String {
        return "\(self)"
    }
}
