import UIKit
import RxSwift
import RxCocoa

protocol WeatherViewControllerDelegate: class {

}

class WeatherViewController: UIViewController {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!

    weak var delegate: WeatherViewControllerDelegate?

    private let viewModel: WeatherViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        viewModel.fetchWeather()
    }

    //MARK: Actions

    @IBAction func refreshTapped() {
        viewModel.fetchWeather()
    }

    //MARK: Helpers

    private func bindViewModel() {
        bind(label: temperatureLabel, to: viewModel.temperature)
        bind(label: pressureLabel, to: viewModel.pressure)
        bind(label: humidityLabel, to: viewModel.humidity)
        bind(label: minTempLabel, to: viewModel.tempMin)
        bind(label: maxTempLabel, to: viewModel.tempMax)
    }

    private func bind(label: UILabel, to observable: Observable<String>) {
        observable
            .asDriver(onErrorJustReturn: "")
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
}
