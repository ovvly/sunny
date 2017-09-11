import Foundation

extension Weather: JSONMappable {
    init(json: JSON) throws {
        guard let mainJson = json["main"] as? JSON else {
            throw ParsingError.InvalidJSON(json)
        }

        let temperature = try String.extract(from: mainJson, key: "temp")
        let humidity = try String.extract(from: mainJson, key: "humidity")
        let pressure = try String.extract(from: mainJson, key: "pressure")
        let tempMin = try String.extract(from: mainJson, key: "temp_min")
        let tempMax = try String.extract(from: mainJson, key: "temp_max")

        self.init(temperature: temperature, humidity: humidity, pressure: pressure, tempMin: tempMin, tempMax: tempMax)
    }
}

//TODO: move this helper to separate class when more Resources will be introduced
private extension String {
    static func extract(from json: JSON, key: String) throws -> String {
        guard let value = json[key] as? String else {
            throw ParsingError.InvalidJSON(json)
        }
        return value
    }
}
