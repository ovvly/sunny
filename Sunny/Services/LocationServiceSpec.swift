import Foundation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class LocationServiceSpec: QuickSpec {

    override func spec() {
        describe("MainLocationService") {
            var sut: MainLocationService!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()

                sut = MainLocationService()
            }

            describe("add location") {
                var result: [Location]!

                context("when adding first location") {

                    beforeEach {
                        sut.add(location: "fixture")
                            .subscribe(onNext: { locations in
                                result = locations
                            })
                            .disposed(by: disposeBag)
                    }

                    it("should return only this location") {
                        expect(result) == ["fixture"]
                    }
                }

                context("when adding more locations") {

                    beforeEach {
                        _ = sut.add(location: "fixture")
                        sut.add(location: "fixture 2")
                            .subscribe(onNext: { locations in
                                result = locations
                            })
                            .disposed(by: disposeBag)
                    }

                    it("should return all saved locations") {
                        expect(result) == ["fixture", "fixture 2"]
                    }
                }
            }

            describe("fetch locations") {
                var result: [Location]!

                beforeEach {
                    _ = sut.add(location: "fixture")
                    _ = sut.add(location: "fixture 2")
                    _ = sut.add(location: "fixture 3")

                    sut.fetchLocations()
                        .subscribe(onNext: { locations in
                            result = locations
                        })
                        .disposed(by: disposeBag)
                }

                it("should return all saved locations") {
                    expect(result) == ["fixture", "fixture 2", "fixture 3"]
                }

                context("when using other service for fetching than for saving") {

                    beforeEach {
                        sut = MainLocationService()

                        sut.fetchLocations()
                            .subscribe(onNext: { locations in
                                result = locations
                            })
                            .disposed(by: disposeBag)
                    }

                    it("should return all saved locations") {
                        expect(result) == ["fixture", "fixture 2", "fixture 3"]
                    }
                }
            }
        }
    }
}
