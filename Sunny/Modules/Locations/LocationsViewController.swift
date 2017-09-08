import UIKit
import RxSwift
import RxCocoa

protocol LocationsViewControllerDelegate: class {
    func viewControllerDidAdd(_ viewController: LocationsViewController)
}

class LocationsViewController: UITableViewController {
    let viewModel: LocationsViewModel
    weak var delegate: LocationsViewControllerDelegate?

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
        setupNavigationItem()
        fetchLocations()
    }

    func added(location: Location) {
        let newLocations = viewModel.add(location: location)
        refreshTableView(with: newLocations)
    }

    //MARK: Actions

    @IBAction private func addButtonTapped() {
        delegate?.viewControllerDidAdd(self)
    }

    //MARK: Helpers

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        dataSource.registerCells(for: tableView)
    }

    private func setupNavigationItem() {
        navigationItem.title = "Locations"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }

    private func fetchLocations() {
        refreshTableView(with: viewModel.loadLocations())
    }

    private func refreshTableView(with locations: Observable<[Location]>) {
        locations
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [unowned self] in
                self.dataSource.locations = $0
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
