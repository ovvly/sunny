import Foundation
import Quick
import Nimble

@testable import Sunny

class WeatherResourceSpec: QuickSpec {
    override func spec() {
        describe("WeatherResource") {

            describe("current at location") {
                var result: Resource<Weather>!

                beforeEach {
                    result = Weather.current(at: Location.fixture())
                }

                it("should have correct path") {
                    expect(result.path) == "weather"
                }

                it("should have correct parameters") {
                    expect(result.parameters) == ["q": Location.fixture(), "appid": AppConfiguration.apiKey]
                }

                it("should have correct method") {
                    expect(result.method) == HTTPMethod.get
                }
            }

            describe("current at coordinates") {
                var result: Resource<Weather>!

                beforeEach {
                    result = Weather.current(at: (latitude: 42.0, longitude: 43.0))
                }

                it("should have correct path") {
                    expect(result.path) == "weather"
                }

                it("should have correct parameters") {
                    expect(result.parameters) == ["lat": "42.0", "lon": "43.0", "appid": AppConfiguration.apiKey]
                }

                it("should have correct method") {
                    expect(result.method) == HTTPMethod.get
                }
            }
        }
    }
}
