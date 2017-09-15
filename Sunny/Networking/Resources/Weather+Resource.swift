import Foundation

extension Weather {
    static func current(at location: String) -> Resource<Weather> {
        //FIXME: move adding api key to api client, it should not be part of weather resource
        return Resource(path: "weather", parameters: ["q": location, "appid": AppConfiguration.apiKey], method: .get, parse: Weather.init)
    }

    static func current(at coordinates: Coordinates) -> Resource<Weather> {
        let lat = String(coordinates.latitude)
        let lon = String(coordinates.longitude)
        return Resource(path: "weather", parameters: ["lat": lat, "lon": lon, "appid": AppConfiguration.apiKey], method: .get, parse: Weather.init)
    }
}
