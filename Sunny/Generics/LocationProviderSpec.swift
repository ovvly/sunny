import Foundation
import CoreLocation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class LocatinoProviderSpec: QuickSpec {
    override func spec() {
        describe("LocatinoProvider") {
            var sut: MainLocationProvider!
            var fakeLocationManager: FakeLocationManager!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                fakeLocationManager = FakeLocationManager()

                sut = MainLocationProvider(locationManager: fakeLocationManager)
            }

            describe("init") {
                it("should have set location manager delegate") {
                    expect(fakeLocationManager.delegate) === sut
                }

                it("should have set location manager desired accuracy") {
                    expect(fakeLocationManager.desiredAccuracy) == kCLLocationAccuracyBest
                }

                it("should have set location manager distance filter") {
                    expect(fakeLocationManager.distanceFilter) == 100
                }
            }

            describe("location manger did update location") {
                var result: String!
                var capturedError: Error!

                beforeEach {
                    sut.currentLocation
                        .subscribe(onNext: { location in
                            result = location
                        }, onError: { error in
                            capturedError = error
                        })
                        .disposed(by: disposeBag)
                }

                context("when there is one location in update") {

                    beforeEach {
                        sut.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 42.0, longitude: 43.0)])
                    }

                    it("should emit location update") {
                        expect(result) == "42.0 43.0"
                    }
                }

                context("when there is more location in updates") {

                    beforeEach {
                        sut.locationManager(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 42.0, longitude: 43.0), CLLocation(latitude: 44.0, longitude: 45.0)])
                    }

                    it("should emit first location update") {
                        expect(result) == "42.0 43.0"
                    }
                }

                context("when there is no location in update") {

                    beforeEach {
                        sut.locationManager(CLLocationManager(), didUpdateLocations: [])
                    }

                    it("should emit error") {
                        expect(capturedError).toNot(beNil())
                    }
                }
            }

            describe("location manager did fail with error") {
                var capturedError: Error!

                beforeEach {
                    sut.currentLocation
                        .subscribe(onError: { error in
                            capturedError = error
                        })
                        .disposed(by: disposeBag)

                    sut.locationManager(CLLocationManager(), didFailWithError: FakeError.fakeTestError)
                }

                it("should emit error") {
                    expect(capturedError).toNot(beNil())
                }
            }

            describe("location manager did cheange authorization status") {

                context("when status is authorized always") {
                    beforeEach {
                        sut.locationManager(CLLocationManager(), didChangeAuthorization: .authorizedAlways)
                    }

                    it("should start updating location on location manager") {
                        expect(fakeLocationManager.didStartUpdatingLocation) == true
                    }
                }

                context("when status is authorized when in use") {
                    beforeEach {
                        sut.locationManager(CLLocationManager(), didChangeAuthorization: .authorizedWhenInUse)
                    }

                    it("should start updating location on location manager") {
                        expect(fakeLocationManager.didStartUpdatingLocation) == true
                    }
                }

                context("when status is other than when in use or always") {
                    beforeEach {
                        sut.locationManager(CLLocationManager(), didChangeAuthorization: .notDetermined)
                    }

                    it("should not start updating location on location manager") {
                        expect(fakeLocationManager.didStartUpdatingLocation) == false
                    }
                }
            }
        }
    }
}

private enum FakeError: Error {
    case fakeTestError
}

extension CLLocation {
    static func fixture() -> CLLocation {
        return CLLocation(latitude: 42.0, longitude: 43.0)
    }
}

private class FakeLocationManager: LocationManager {
    var delegate: CLLocationManagerDelegate?
    var desiredAccuracy: Double = 0.0
    var distanceFilter: Double = 0.0

    var didStartUpdatingLocation = false
    var requestedWhenInUseAuthorization = false

    func requestWhenInUseAuthorization() {
        requestedWhenInUseAuthorization = true
    }

    func startUpdatingLocation() {
        didStartUpdatingLocation = true
    }
}
