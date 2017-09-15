import UIKit

protocol LocationsDataSource: UITableViewDataSource {
    var locations: [Location] { get set }
    func registerCells(for tableView: UITableView)
}

class MainLocationsDataSource: NSObject, LocationsDataSource {
    var locations = [Location]()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = "current location"
        } else {
            cell.textLabel?.text = locations[indexPath.row]
        }
        
        return cell
    }

    func registerCells(for tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    private struct Constants {
        static let cellIdentifier = "LocationsCellIdentifier"
    }
}
