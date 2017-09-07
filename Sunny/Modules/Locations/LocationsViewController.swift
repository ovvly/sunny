import UIKit
import RxSwift
import RxCocoa

class LocationsViewController: UITableViewController {
    let viewModel: LocationsViewModel

    private let dataSource: LocationsDataSource
    private let disposeBag = DisposeBag()

    init(viewModel: LocationsViewModel, dataSource: LocationsDataSource = LocationsDataSource()) {
        self.viewModel = viewModel
        self.dataSource = dataSource

        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchLocations()
    }

    //MARK: Helpers

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        dataSource.registerCells(for: tableView)
    }

    private func fetchLocations() {
        viewModel.loadLocations()
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [unowned self] locations in
                self.dataSource.locations = locations
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
