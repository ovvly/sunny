import Foundation
import Quick
import Nimble

@testable import Sunny

class LocationsDataSourceSpec: QuickSpec {
    override func spec() {
        describe("LocationsDataSource") {
            var sut: LocationsDataSource!

            beforeEach {
                sut = MainLocationsDataSource()
            }

            describe("number of sections in table view") {
                var result: Int!

                beforeEach {
                    result = sut.numberOfSections!(in: UITableView())
                }

                it("should return 2 sections") {
                    expect(result) == 2
                }
            }

            describe("table view number of rows in section") {
                var result: Int!

                context("for section 0") {
                    beforeEach {
                        result = sut.tableView(UITableView(), numberOfRowsInSection: 0)
                    }

                    it("should return 1") {
                        expect(result) == 1
                    }
                }

                context("for section 1") {
                    context("without provided locations") {

                        beforeEach {
                            result = sut.tableView(UITableView(), numberOfRowsInSection: 1)
                        }

                        it("should return 0") {
                            expect(result) == 0
                        }
                    }

                    context("after setting locations") {

                        beforeEach {
                            sut.locations = [Location.fixture()]

                            result = sut.tableView(UITableView(), numberOfRowsInSection: 1)
                        }
                        
                        it("should return number of locations") {
                            expect(result) == 1
                        }
                    }
                }
            }

            describe("cell for row at index path") {
                var result: UITableViewCell!
                var tableView: UITableView!

                beforeEach {
                    sut.locations = [Location.fixture()]
                    tableView = UITableView()
                    tableView.dataSource = sut
                    sut.registerCells(for: tableView)
                }

                context("for section 0") {
                    beforeEach {
                        result = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                    }

                    it("should retiurn current location as title") {
                        expect(result.textLabel?.text) == "current location"
                    }
                }

                context("for section 1") {
                    beforeEach {
                        result = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1))
                    }

                    it("should retiurn location name as title") {
                        expect(result.textLabel?.text) == "fixture location"
                    }
                }
            }
        }
    }
}
