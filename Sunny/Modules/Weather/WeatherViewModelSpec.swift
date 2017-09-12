import Foundation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class WeatherViewModelSpec: QuickSpec {
    override func spec() {
        describe("WeatherViewModel") {
            var sut: WeatherViewModel!
            var fakeWeatherService: FakeWeatherService!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                fakeWeatherService = FakeWeatherService()
                sut = MainWeatherViewModel(weatherService: fakeWeatherService, location: Location.fixture())
            }

            describe("weather fetching") {
                var temperatureString: String!
                var humidityString: String!
                var pressureString: String!
                var tempMinString: String!
                var tempMaxString: String!

                beforeEach {
                    sut.temperature
                        .subscribe(onNext: { temperatureString = $0 })
                        .disposed(by: disposeBag)
                    sut.humidity
                        .subscribe(onNext: { humidityString = $0 })
                        .disposed(by: disposeBag)
                    sut.pressure
                        .subscribe(onNext: { pressureString = $0 })
                        .disposed(by: disposeBag)
                    sut.tempMin
                        .subscribe(onNext: { tempMinString = $0 })
                        .disposed(by: disposeBag)
                    sut.tempMax
                        .subscribe(onNext: { tempMaxString = $0 })
                        .disposed(by: disposeBag)

                   sut.fetchWeather()
                }

                it("should emit correct temerature") {
                    expect(temperatureString) ==  "42.0 °F"
                }

                it("should emit correct pressure") {
                    expect(pressureString) ==  "42.0 hpa"
                }

                it("should emit correct humidity") {
                    expect(humidityString) ==  "42.0 %"
                }

                it("should emit correct temp min") {
                    expect(tempMinString) ==  "42.0 °F"
                }

                it("should emit correct temp max") {
                    expect(tempMaxString) ==  "42.0 °F"
                }
            }
        }
    }
}

private class FakeWeatherService: WeatherService {

    func weather(for location: Location) -> Observable<Weather> {
        return Observable.just(Weather.fixture())
    }
}
