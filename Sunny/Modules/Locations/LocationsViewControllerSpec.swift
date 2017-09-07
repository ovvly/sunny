import Foundation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class LocationsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("LocationsViewController") {
            var sut: LocationsViewController!
            var fakeViewModel: FakeLocationsViewModel!
            var fakeDataSource: FakeLocationsDataSource!

            beforeEach {
                fakeViewModel = FakeLocationsViewModel()
                fakeDataSource = FakeLocationsDataSource()
                sut = LocationsViewController(viewModel: fakeViewModel, dataSource: fakeDataSource)
            }

            describe("view did load") {
                beforeEach {
                    sut.viewDidLoad()
                }

                describe("table view") {

                    it("should have table view footer") {
                        expect(sut.tableView.tableFooterView).toNot(beNil())
                    }

                    it("should have data source") {
                        expect(sut.tableView.dataSource).toNot(beNil())
                    }

                    //TODO: Find better way to test this than fake data source injection
                    it("should register cells for table view") {
                        expect(fakeDataSource.didRegisterCells) == true
                    }
                }

                describe("location fetching") {

                    it("should fetch locations") {
                        expect(fakeViewModel.didRequestedLocations) == true
                    }
                }
            }

            describe("location fetch handling") {
                var fakeTableView: FakeTableView!

                beforeEach {
                    fakeTableView = FakeTableView()
                    sut.tableView = fakeTableView

                    sut.viewDidLoad()
                }

                it("should set locations in data source") {
                    expect(fakeDataSource.locations) == Location.fixture()
                }

                it("should reload table view") {
                    expect(fakeTableView.didReloadData) == true
                }
            }
        }
    }
}

private class FakeLocationsViewModel: LocationsViewModel {
    var didRequestedLocations = false

    func loadLocations() -> Observable<[Location]> {
        didRequestedLocations = true
        return Observable.just(Location.fixture())
    }
}

private class FakeLocationsDataSource: LocationsDataSource {
    var didRegisterCells = false

    override func registerCells(for tableView: UITableView) {
        didRegisterCells = true
    }
}

private class FakeTableView: UITableView {
    var didReloadData = false

    override func reloadData() {
        didReloadData = true
    }
}
