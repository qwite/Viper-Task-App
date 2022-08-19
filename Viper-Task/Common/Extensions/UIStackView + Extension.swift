import UIKit

// MARK: - UIStackView Extension
extension UIStackView {
    convenience init(arrangedSubviews: [UIView],
                     spacing: CGFloat? = nil,
                     axis: NSLayoutConstraint.Axis,
                     alignment: Alignment) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing ?? 0.0
        self.axis = axis
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
