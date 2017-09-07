import Foundation
import UIKit
import RxSwift

protocol LocationsViewModel {
    func loadLocations() -> Observable<[Location]>
}

class MainLocationsViewModel: LocationsViewModel {
    private let locationService: LocationService

    init(locationService: LocationService) {
        self.locationService = locationService
    }

    func loadLocations() -> Observable<[Location]> {
        return locationService.fetchLocations()
    }
}
