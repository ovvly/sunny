import Foundation
import RxSwift

protocol LocationService {
    func fetchLocations() -> Observable<[Location]>
    func add(location: Location) -> Observable<[Location]>
}

class MainLocationService: LocationService {
    private static let locationsFileName = "Locations"

    private var locations = [Location]()

    func fetchLocations() -> Observable<[Location]> {
        do {
            locations = try readLocations()
        } catch let error {
            return Observable.error(error)
        }
        return Observable.just(locations)
    }

    func add(location: Location) -> Observable<[Location]> {
        locations.append(location)
        do {
            try writeLocations()
        } catch let error {
            return Observable.error(error)
        }
        return Observable.just(locations)
    }

    //MARK: Helpers

    private func pathForLocations() throws -> String {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw RxError.noElements
        }
        return url.appendingPathComponent(MainLocationService.locationsFileName).path
    }

    private func readLocations() throws -> [Location] {
        let path = try pathForLocations()

        guard let result = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Location] else {
            return []
        }
        return result
    }

    private func writeLocations() throws {
        let path = try pathForLocations()
        NSKeyedArchiver.archiveRootObject(locations, toFile: path)
    }
}
