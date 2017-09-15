import Foundation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class LocationsViewModelSpec: QuickSpec {
    override func spec() {
        describe("LocationsViewModel") {
            var sut: MainLocationsViewModel!
            var fakeLocationService: FakeLocationService!
            var fakeLocationProvider: FakeLocationProvider!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                fakeLocationService = FakeLocationService()
                fakeLocationProvider = FakeLocationProvider()
                sut = MainLocationsViewModel(locationService: fakeLocationService, locationProvider: fakeLocationProvider)
            }

            describe("load locations") {
                var result: [Location]!

                beforeEach {
                    sut.loadLocations()
                        .subscribe(onNext: { locations in
                            result = locations
                        })
                        .disposed(by: disposeBag)
                }

                it("should return locations from service") {
                    expect(result) == fakeLocationService.locations
                }
            }

            describe("add location") {
                var result: [Location]!

                beforeEach {
                    sut.add(location: Location.fixture())
                        .subscribe(onNext: { locations in
                            result = locations
                        })
                        .disposed(by: disposeBag)
                }

                it("should pass location to add") {
                    expect(fakeLocationService.capturedLocation) == Location.fixture()
                }

                it("should return locations from service") {
                    expect(result) == fakeLocationService.locations
                }
            }

            describe("current location") {
                var result: Location!

                beforeEach {
                    sut.currentLocation()
                        .subscribe(onNext: { location in
                            result = location
                        })
                        .disposed(by: disposeBag)
                }

                it("should current location from service") {
                    expect(result) == "current fixture location"
                }
            }
        }
    }
}

private class FakeLocationService: LocationService {
    let locations = [Location.fixture()]
    var capturedLocation: Location?

    func fetchLocations() -> Observable<[Location]> {
        return Observable.just(locations)
    }

    func add(location: String) -> Observable<[Location]> {
        capturedLocation = location
        return Observable.just(locations)
    }
}

private class FakeLocationProvider: LocationProvider {
    var currentLocation: Observable<Location> {
        return Observable.just("current fixture location")
    }
}
