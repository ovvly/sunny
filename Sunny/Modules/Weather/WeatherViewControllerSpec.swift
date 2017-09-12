import Foundation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class WeatherViewControllerSpec: QuickSpec {
    override func spec() {
        describe("WeatherViewController") {
            var sut: WeatherViewController!
            var fakeViewModel: FakeWeatherViewViewModel!
            var fakeDelegate: FakeWeatherViewControllerDelegate!

            beforeEach {
                fakeViewModel = FakeWeatherViewViewModel()
                fakeDelegate = FakeWeatherViewControllerDelegate()

                sut = WeatherViewController(viewModel: fakeViewModel)
                sut.delegate = fakeDelegate
            }

            describe("view did load") {
                beforeEach {
                    //view controller loads view hierarchy (and outlets) when view is accessed for the first time
                    _ = sut.view

                    sut.viewDidLoad()
                }

                it("should request for weather") {
                    expect(fakeViewModel.weatherRequested) == true
                }

                describe("weather fetch handling") {
                    it("should populate fields with data") {
                        expect(sut.temperatureLabel.text) == "fixture temp"
                        expect(sut.humidityLabel.text) == "fixture humidity"
                        expect(sut.pressureLabel.text) == "fixture pressure"
                        expect(sut.minTempLabel.text) == "fixture min temp"
                        expect(sut.maxTempLabel.text) == "fixture max temp"
                    }
                }
            }
        }
    }
}

private class FakeWeatherViewControllerDelegate: WeatherViewControllerDelegate { }

private class FakeWeatherViewViewModel: WeatherViewModel {
    var weatherRequested = false

    var temperature: Observable<String> {
        return Observable.just("fixture temp")
    }
    
    var humidity: Observable<String> {
        return Observable.just("fixture humidity")
    }

    var pressure: Observable<String> {
        return Observable.just("fixture pressure")
    }

    var tempMin: Observable<String> {
        return Observable.just("fixture min temp")
    }

    var tempMax: Observable<String> {
        return Observable.just("fixture max temp")
    }

    func fetchWeather() {
        weatherRequested = true
    }
}
