import Foundation

struct Weather {
    let temperature: String
    let humidity: String
    let pressure: String
    let tempMin: String
    let tempMax: String
}

extension Weather: Equatable { }

func ==(lhs: Weather, rhs: Weather) -> Bool {
    return lhs.humidity == rhs.humidity && lhs.temperature == rhs.temperature && lhs.pressure == rhs.pressure && lhs.tempMin == rhs.tempMin && lhs.tempMax == rhs.tempMax
}
