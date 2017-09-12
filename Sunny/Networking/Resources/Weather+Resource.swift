import Foundation

extension Weather {
    static func current(in location: Location) -> Resource<Weather> {
        //FIXME: move adding api key to api client, it should not be part of weather resource
        return Resource(path: "weather", parameters: ["q": location, "appid": AppConfiguration.apiKey], method: .get, parse: Weather.init)
    }
}
