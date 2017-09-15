import Foundation
import Quick
import Nimble

@testable import Sunny

class LocationSpec: QuickSpec {

    override func spec() {
        describe("Location") {
            var sut: Location!

            describe("coordinates") {

                context("when location contains coordinates separated by space") {

                    beforeEach {
                        sut = "42 42"
                    }

                    it("should return coordinates") {
                        expect(sut.coordinates?.longitude) == 42
                        expect(sut.coordinates?.latitude) == 42
                    }
                }

                context("when location contains coordinates separated by ;") {

                    beforeEach {
                        sut = "42;42"
                    }

                    it("should return coordinates") {
                        expect(sut.coordinates?.longitude) == 42
                        expect(sut.coordinates?.latitude) == 42
                    }
                }

                context("when location contains double coordinates separates by space") {

                    beforeEach {
                        sut = "42.0 42.0"
                    }

                    it("should return coordinates") {
                        expect(sut.coordinates?.longitude) == 42
                        expect(sut.coordinates?.latitude) == 42
                    }
                }

                context("when location contains one coordinate") {

                    beforeEach {
                        sut = "42"
                    }

                    it("should not return coordinates") {
                        expect(sut.coordinates).to(beNil())
                    }
                }

                context("when location contains one coordinate and separator") {

                    beforeEach {
                        sut = "42 "
                    }

                    it("should not return coordinates") {
                        expect(sut.coordinates).to(beNil())
                    }
                }

                context("when location contains more than 2 coordinates") {

                    beforeEach {
                        sut = "42 42 42"
                    }

                    it("should not return coordinates") {
                        expect(sut.coordinates).to(beNil())
                    }
                }

                context("when location contains 2 non numeric values") {

                    beforeEach {
                        sut = "fixture fixture"
                    }

                    it("should not return coordinates") {
                        expect(sut.coordinates).to(beNil())
                    }
                }
            }
        }
    }
}
