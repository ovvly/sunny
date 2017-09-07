import Foundation
import Quick
import Nimble

@testable import Sunny

class LocationsDataSourceSpec: QuickSpec {
    override func spec() {
        describe("LocationsDataSource") {
            var sut: LocationsDataSource!

            beforeEach {
                sut = LocationsDataSource()
            }

            describe("table view number of rows in section") {
                var result: Int!

                context("without provided locations") {

                    beforeEach {
                        result = sut.tableView(UITableView(), numberOfRowsInSection: 0)
                    }

                    it("should return 0") {
                        expect(result) == 0
                    }
                }

                context("after setting locations") {

                    beforeEach {
                        sut.locations = Location.fixture()
                        
                        result = sut.tableView(UITableView(), numberOfRowsInSection: 0)
                    }

                    it("should return number of locations") {
                        expect(result) == 1
                    }
                }
            }

            describe("cell for row at index path") {
                var result: UITableViewCell!

                beforeEach {
                    sut.locations = Location.fixture()
                    let tableView = UITableView()
                    tableView.dataSource = sut
                    sut.registerCells(for: tableView)

                    result = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                }

                it("should set correct title") {
                    expect(result.textLabel?.text) == "fixture location"
                }
            }
        }
    }
}
