import UIKit

typealias MainViewController = UIViewController

protocol ControllerFactory {
    func buildMainViewController() -> MainViewController
 }

final class MainControllerFactory: ControllerFactory {

    func buildMainViewController() -> MainViewController {
        return ViewController()
    }
}

