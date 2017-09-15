import Foundation
import UIKit
import RxSwift

protocol LocationsViewModel {
    func loadLocations() -> Observable<[Location]>
    func add(location: Location) -> Observable<[Location]>
    func currentLocation() -> Observable<Location>
}

class MainLocationsViewModel: LocationsViewModel {
    private let locationService: LocationService
    private let locationProvider: LocationProvider

    init(locationService: LocationService, locationProvider: LocationProvider) {
        self.locationService = locationService
        self.locationProvider = locationProvider
    }

    func loadLocations() -> Observable<[Location]> {
        return locationService.fetchLocations()
    }

    func add(location: Location) -> Observable<[Location]> {
        return locationService.add(location: location)
    }

    func currentLocation() -> Observable<Location> {
        return locationProvider.currentLocation
    }
}
