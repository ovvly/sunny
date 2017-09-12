import Foundation

@testable import Sunny

extension Weather {
    static func fixture() -> Weather {
        return Weather(temperature: 42, humidity: 42, pressure: 42, tempMin: 42, tempMax: 42)
    }
}
