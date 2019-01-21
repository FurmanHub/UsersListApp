import UIKit

public extension UIView {
    
    func install(_ subview: UIView, configuration: (UIView) -> Void) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        configuration(self)
    }
    
}
