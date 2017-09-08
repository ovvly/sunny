import Foundation
import RxSwift

protocol LocationService {
    func fetchLocations() -> Observable<[Location]>
    func add(location: Location) -> Observable<[Location]>
}

class PlistLocationService: LocationService {
    private var locations = [Location]()

    func fetchLocations() -> Observable<[Location]> {
        do {
            let url = try urlForLocations()
            locations = try readLocations(from: url)

        } catch let error {
            return Observable.error(error)
        }
        return Observable.just(locations)
    }

    func add(location: Location) -> Observable<[Location]> {
        locations.append(location)
        do {
            try saveLocationsToPlist()
        } catch let error {
            return Observable.error(error)
        }
        return Observable.just(locations)
    }

    //MARK: Helpers

    private func urlForLocations() throws -> URL {
        guard let url = Bundle.main.url(forResource: "Locations", withExtension: "plist") else {
            throw RxError.noElements
        }
        return url
    }

    private func readLocations(from url: URL) throws -> [Location] {
        let data = try Data(contentsOf: url)
        guard let result = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String] else {
            throw RxError.noElements
        }
        return result
    }

    private func saveLocationsToPlist() throws {
        try (locations as NSArray).write(to: urlForLocations(), atomically: true)
    }
}
