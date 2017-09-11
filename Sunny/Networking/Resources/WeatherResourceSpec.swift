import Foundation
import Quick
import Nimble

@testable import Sunny

class WeatherResourceSpec: QuickSpec {
    override func spec() {
        describe("WeatherResource") {

            describe("current") {
                var result: Resource<Weather>!

                beforeEach {
                    result = Weather.current(in: Location.fixture())
                }

                it("should have correct path") {
                    expect(result.path) == "weather"
                }

                it("should have correct parameters") {
                    expect(result.parameters) == ["q": Location.fixture()]
                }

                it("should have correct method") {
                    expect(result.method) == HTTPMethod.get
                }
            }
        }
    }
}
