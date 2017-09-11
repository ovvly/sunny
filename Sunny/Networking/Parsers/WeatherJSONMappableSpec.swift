import Foundation
import Quick
import Nimble

@testable import Sunny

class WeatherJSONMappableSpec: QuickSpec {
    override func spec() {
        describe("Weather+JSONMappable") {
            var result: Weather!
            var error: Error!

            context("when initialized with correct json") {
                beforeEach {
                    let json = ["main": ["temp": "fixture temp",
                                "humidity": "fixture humidity",
                                "pressure": "fixture pressure",
                                "temp_min": "fixture min temp",
                                "temp_max": "fixture max temp"]]

                    result = try? Weather(json: json)
                }

                it("should return correct weather") {
                    expect(result) == Weather.fixture()
                }
            }

            context("when main key is missing") {
                beforeEach {
                    let json = ["temp": "fixture temp",
                                "humidity": "fixture humidity",
                                "pressure": "fixture pressure",
                                "temp_min": "fixture min temp",
                                "temp_max": "fixture max temp"]
                    do {
                        result = try Weather(json: json)
                    } catch let err {
                        error = err
                    }
                }

                it("should throw error") {
                    expect(error).toNot(beNil())
                }
            }

            context("when temp key is missing") {
                beforeEach {
                    let json = ["main": ["humidity": "fixture humidity",
                                         "pressure": "fixture pressure",
                                         "temp_min": "fixture min temp",
                                         "temp_max": "fixture max temp"]]
                    do {
                        result = try Weather(json: json)
                    } catch let err {
                        error = err
                    }
                }

                it("should throw error") {
                    expect(error).toNot(beNil())
                }
            }

            context("when humidity key is missing") {
                beforeEach {
                    let json = ["main": ["temp": "fixture temp",
                                         "pressure": "fixture pressure",
                                         "temp_min": "fixture min temp",
                                         "temp_max": "fixture max temp"]]
                    do {
                        result = try Weather(json: json)
                    } catch let err {
                        error = err
                    }
                }

                it("should throw error") {
                    expect(error).toNot(beNil())
                }
            }

            context("when pressure key is missing") {
                beforeEach {
                    let json = ["main": ["temp": "fixture temp",
                                         "humidity": "fixture humidity",
                                         "temp_min": "fixture min temp",
                                         "temp_max": "fixture max temp"]]
                    do {
                        result = try Weather(json: json)
                    } catch let err {
                        error = err
                    }
                }

                it("should throw error") {
                    expect(error).toNot(beNil())
                }
            }

            context("when temp_min key is missing") {
                beforeEach {
                    let json = ["main": ["temp": "fixture temp",
                                         "humidity": "fixture humidity",
                                         "pressure": "fixture pressure",
                                         "temp_max": "fixture max temp"]]
                    do {
                        result = try Weather(json: json)
                    } catch let err {
                        error = err
                    }
                }

                it("should throw error") {
                    expect(error).toNot(beNil())
                }
            }

            context("when temp_max key is missing") {
                beforeEach {
                    let json = ["main": ["temp": "fixture temp",
                                         "humidity": "fixture humidity",
                                         "pressure": "fixture pressure",
                                         "temp_min": "fixture min temp"]]
                    do {
                        result = try Weather(json: json)
                    } catch let err {
                        error = err
                    }
                }

                it("should throw error") {
                    expect(error).toNot(beNil())
                }
            }
        }
    }
}
