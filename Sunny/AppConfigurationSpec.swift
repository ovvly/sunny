import Foundation
import Quick
import Nimble

@testable import Sunny

class AppConfigurationSpec: QuickSpec {

    override func spec() {
        describe("AppConfiguration") {
            it("should have correct base url") {
                expect(AppConfiguration.baseUrl) == URL(string: "http://api.openweathermap.org/data/2.5")!
            }

            it("should have correct api key") {
                expect(AppConfiguration.apiKey) == "4e41c354247b9bff4a9fa26f51307ec7"
            }
        }
    }
}
