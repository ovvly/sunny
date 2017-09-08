import UIKit

class MainViewController: UINavigationController {
    var locationsViewController: LocationsViewController {
        return viewControllers[0] as! LocationsViewController
    }
}
