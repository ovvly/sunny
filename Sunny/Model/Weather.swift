import Foundation

struct Weather {
    let temperature: Double
    let humidity: Double
    let pressure: Double
    let tempMin: Double
    let tempMax: Double
}

extension Weather: Equatable { }

func ==(lhs: Weather, rhs: Weather) -> Bool {
    return lhs.humidity == rhs.humidity && lhs.temperature == rhs.temperature && lhs.pressure == rhs.pressure && lhs.tempMin == rhs.tempMin && lhs.tempMax == rhs.tempMax
}
