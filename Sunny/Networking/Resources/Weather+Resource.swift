import Foundation

extension Weather {
    static func current(in location: Location) -> Resource<Weather> {
        return Resource(path: "weather", parameters: ["q": location], method: .get, parse: Weather.init)
    }
}
