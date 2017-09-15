import UIKit
import RxSwift
import RxCocoa

protocol LocationsViewControllerDelegate: class {
    func viewControllerDidAdd(_ viewController: LocationsViewController)
    func viewController(_ viewController: LocationsViewController, selected location: Location)
}

class LocationsViewController: UITableViewController {
    let viewModel: LocationsViewModel
    weak var delegate: LocationsViewControllerDelegate?

    private let dataSource: LocationsDataSource
    private let currentLocationSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    init(viewModel: LocationsViewModel, dataSource: LocationsDataSource = MainLocationsDataSource()) {
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
        setupCurrentLocationHandling()
    }

    func added(location: Location) {
        let newLocations = viewModel.add(location: location)
        refreshTableView(with: newLocations)
    }

    //MARK: Actions

    @IBAction private func addButtonTapped() {
        delegate?.viewControllerDidAdd(self)
    }

    //MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            currentLocationSubject.onNext(())
        } else {
            let location = dataSource.locations[indexPath.row]
            delegate?.viewController(self, selected: location)
        }
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

    private func setupCurrentLocationHandling() {
        currentLocationSubject
            .debug()
            .withLatestFrom(viewModel.currentLocation())
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [unowned self] location in
                self.delegate?.viewController(self, selected: location)
            })
            .disposed(by: disposeBag)
    }
}
