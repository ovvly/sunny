import UIKit

extension UIBarButtonItem {
    func simulateTap() {
        UIApplication.shared.sendAction(self.action!, to: self.target, from: nil, for: nil)
    }
}
