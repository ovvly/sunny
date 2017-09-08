import UIKit
import RxSwift
import RxCocoa

protocol LocationAddingViewControllerDelegate: class {
    func viewController(_ viewController: LocationAddingViewController, didAdd location: Location)
}

class LocationAddingViewController: UIViewController {
    weak var delegate: LocationAddingViewControllerDelegate?

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFieldValidation()
    }

    //MARK: Actions

    @IBAction func addTapped(_ sender: UIButton) {
        let location = locationTextField.text ?? ""
        delegate?.viewController(self, didAdd: location)
    }

    //MARK: Helpers

    private func setupTextFieldValidation() {
        locationTextField.rx.text
            .map { return !($0 ?? "").isEmpty }
            .asDriver(onErrorJustReturn: false)
            .drive(addButton.rx.isEnabled)
            .disposed(by: bag)
    }
}
