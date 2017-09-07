import Foundation
import UIKit

protocol LocationsViewModel {
    func setup(tableView: UITableView)
}

class MainLocationsViewModel: LocationsViewModel {
    private let dataSource = LocationsDataSource()

    func setup(tableView: UITableView) {
        tableView.dataSource = dataSource
    }
}
