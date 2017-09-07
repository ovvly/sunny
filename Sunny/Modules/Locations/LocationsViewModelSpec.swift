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
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                fakeLocationService = FakeLocationService()
                sut = MainLocationsViewModel(locationService: fakeLocationService)
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
        }
    }
}

private class FakeLocationService: LocationService {
    let locations = Location.fixture()

    func fetchLocations() -> Observable<[Location]> {
        return Observable.just(locations)
    }
}
