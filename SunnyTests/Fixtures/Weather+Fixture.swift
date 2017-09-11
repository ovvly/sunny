import Foundation

@testable import Sunny

extension Weather {
    static func fixture() -> Weather {
        return Weather(temperature: "fixture temp", humidity: "fixture humidity", pressure: "fixture pressure", tempMin: "fixture min temp", tempMax: "fixture max temp")
    }
}
