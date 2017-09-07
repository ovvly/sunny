import Foundation
import RxSwift

protocol LocationService {
    func fetchLocations() -> Observable<[Location]>
}

class MainLocationService: LocationService {
    
    func fetchLocations() -> Observable<[Location]> {
        return Observable.just(["Warsaw", "Paris", "London"])
    }
}
