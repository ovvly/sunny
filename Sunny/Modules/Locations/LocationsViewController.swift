import UIKit

class LocationsViewController: UITableViewController {
    let viewModel: LocationsViewModel

    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel

        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    //MARK: Helpers

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        viewModel.setup(tableView: tableView)
    }
}
