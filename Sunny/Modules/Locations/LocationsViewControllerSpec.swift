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
            var fakeDelegate: FakeLocationViewControllerDelegate!

            beforeEach {
                fakeViewModel = FakeLocationsViewModel()
                fakeDataSource = FakeLocationsDataSource()
                fakeDelegate = FakeLocationViewControllerDelegate()

                sut = LocationsViewController(viewModel: fakeViewModel, dataSource: fakeDataSource)
                sut.delegate = fakeDelegate
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

                describe("navigation item") {

                    it("should have title") {
                        expect(sut.navigationItem.title) == "Locations"
                    }

                    describe("add bar button item") {
                        var buttonItem: UIBarButtonItem!

                        beforeEach {
                            buttonItem = sut.navigationItem.rightBarButtonItem
                        }

                        describe("when is tapped") {

                            beforeEach {
                                buttonItem.simulateTap()
                            }

                            it("should inform delegate") {
                                expect(fakeDelegate.capturedViewController) === sut
                            }
                        }
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
                    expect(fakeDataSource.locations) == [Location.fixture()]
                }

                it("should reload table view") {
                    expect(fakeTableView.didReloadData) == true
                }
            }

            describe("table view did select row at index path") {

                context("when selecting current location") {

                    beforeEach {
                        sut.viewDidLoad()

                        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
                    }

                    it("should pass current location from view model to delegate") {
                        expect(fakeDelegate.capturedViewController) === sut
                        expect(fakeDelegate.capturedLocation) == "fixture location"
                    }
                }

                context("when selecting other location") {

                    beforeEach {
                        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 1))
                    }

                    it("should pass location from data source to delegate") {
                        expect(fakeDelegate.capturedViewController) === sut
                        expect(fakeDelegate.capturedLocation) == fakeDataSource.locations[0]
                    }
                }
            }
        }
    }
}

private class FakeLocationsViewModel: LocationsViewModel {
    var didRequestedLocations = false
    var addedLocation: Location? = nil

    func loadLocations() -> Observable<[Location]> {
        didRequestedLocations = true
        return Observable.just([Location.fixture()])
    }

    func add(location: Location) -> Observable<[Location]> {
        addedLocation = location
        return Observable.just([Location.fixture()])
    }

    func currentLocation() -> Observable<Location> {
        return Observable.just(Location.fixture())
    }
}

private class FakeLocationsDataSource: NSObject, LocationsDataSource {
    var didRegisterCells = false

    var locations = [Location.fixture()]

    func registerCells(for tableView: UITableView) {
        didRegisterCells = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

private class FakeTableView: UITableView {
    var didReloadData = false

    override func reloadData() {
        didReloadData = true
    }
}

private class FakeLocationViewControllerDelegate: LocationsViewControllerDelegate {
    var capturedViewController: UIViewController? = nil
    var capturedLocation: Location? = nil

    func viewControllerDidAdd(_ viewController: LocationsViewController) {
        capturedViewController = viewController
    }

    func viewController(_ viewController: LocationsViewController, selected location: Location) {
        capturedViewController = viewController
        capturedLocation = location
    }
}
