import Foundation
import Quick
import Nimble

@testable import Sunny

class AppConfigurationSpec: QuickSpec {

    override func spec() {
        describe("AppConfiguration") {
            it("should have correct base url") {
                expect(AppConfiguration.baseUrl) == URL(string: "http://api.openweathermap.org/data/2.5/weather")!
            }
        }
    }
}
