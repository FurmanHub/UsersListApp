import UIKit

extension UIView: LayoutObject {}
extension UILayoutGuide: LayoutObject {}

private extension UIView {
    
    func constraint<Side: LayoutSide>(_ side: Side, to target: UIView, side targetSide: Side, relation: LayoutRelation, constant: CGFloat, toSafeAreas: Bool) {
        let targetLayoutObject: LayoutObject = toSafeAreas ? target.safeAreaLayoutGuide : target
        
        constraint(side, to: targetLayoutObject, side: targetSide, relation: relation, constant: constant)
    }
    
}

public extension UIView {
    
    func pinTop(to view: UIView, _ side: VerticalSide = .top, relation: LayoutRelation = .equal, constant: CGFloat = 0.0, toSafeAreas: Bool = false) {
        constraint(.top, to: view, side: side, relation: relation, constant: constant, toSafeAreas: toSafeAreas)
    }
    
    func pinBottom(to view: UIView, _ side: VerticalSide = .bottom, relation: LayoutRelation = .equal, constant: CGFloat = 0.0, toSafeAreas: Bool = false) {
        constraint(.bottom, to: view, side: side, relation: relation, constant: constant, toSafeAreas: toSafeAreas)
    }
    
    func pinLeading(to view: UIView, _ side: HorizontalSide = .leading, relation: LayoutRelation = .equal, constant: CGFloat = 0.0, toSafeAreas: Bool = false) {
        constraint(.leading, to: view, side: side, relation: relation, constant: constant, toSafeAreas: toSafeAreas)
    }
    
    func pinTrailing(to view: UIView, _ side: HorizontalSide = .trailing, relation: LayoutRelation = .equal, constant: CGFloat = 0.0, toSafeAreas: Bool = false) {
        constraint(.trailing, to: view, side: side, relation: relation, constant: constant, toSafeAreas: toSafeAreas)
    }
    
    func pinCenterX(to view: UIView, _ side: HorizontalSide = .centerX, relation: LayoutRelation = .equal, constant: CGFloat = 0.0, toSafeAreas: Bool = false) {
        constraint(.centerX, to: view, side: side, relation: relation, constant: constant, toSafeAreas: toSafeAreas)
    }
    
    func pinCenterY(to view: UIView, _ side: VerticalSide = .centerY, relation: LayoutRelation = .equal, constant: CGFloat = 0.0, toSafeAreas: Bool = false) {
        constraint(.centerY, to: view, side: side, relation: relation, constant: constant, toSafeAreas: toSafeAreas)
    }
    
}
