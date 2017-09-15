import Foundation

typealias Location = String
typealias Coordinates = (latitude: Double, longitude: Double)

extension Location {
    var coordinates: Coordinates? {
        let coordinatesArray = components(separatedBy: CharacterSet(charactersIn: " ;"))
        guard coordinatesArray.count == 2 else {
            return nil
        }
        guard let latitude = Double(coordinatesArray[0]), let longitude = Double(coordinatesArray[1]) else {
            return nil
        }
        return (longitude, latitude)
    }
}
