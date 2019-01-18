import UIKit


extension LayoutObject {
    
    func constraint(dimension: NSLayoutDimension, to toDimension: NSLayoutDimension, relation: LayoutRelation, constant: CGFloat) {
        let constraintCreator: () -> NSLayoutConstraint = {
            switch relation {
            case .equal:
                return dimension.constraint(equalTo: toDimension, constant: constant)
            case .greaterThanOrEqual:
                return dimension.constraint(greaterThanOrEqualTo: toDimension, constant: constant)
            case .lessThanOrEqual:
                return dimension.constraint(lessThanOrEqualTo: toDimension, constant: constant)
            }
        }
        
        constraintCreator().isActive = true
    }
    
    func constraint(dimension: NSLayoutDimension, to constant: CGFloat = 0.0, relation: LayoutRelation) {
        let constraintCreator: () -> NSLayoutConstraint = {
            switch relation {
            case .equal:
                return dimension.constraint(equalToConstant: constant)
            case .greaterThanOrEqual:
                return dimension.constraint(greaterThanOrEqualToConstant: constant)
            case .lessThanOrEqual:
                return dimension.constraint(lessThanOrEqualToConstant: constant)
            }
        }
        
        constraintCreator().isActive = true
    }
    
    func constraint<T: AnyObject>(fromAnchor: NSLayoutAnchor<T>, toAnchor: NSLayoutAnchor<T>, relation: LayoutRelation, constant: CGFloat) {
        let constraintCreator: () -> NSLayoutConstraint = {
            switch relation {
            case .equal:
                return fromAnchor.constraint(equalTo: toAnchor, constant: constant)
            case .greaterThanOrEqual:
                return fromAnchor.constraint(greaterThanOrEqualTo: toAnchor, constant: constant)
            case .lessThanOrEqual:
                return fromAnchor.constraint(lessThanOrEqualTo: toAnchor, constant: constant)
            }
        }
        
        constraintCreator().isActive = true
    }
    
    func constraint<Side: LayoutSide>(_ side: Side, to target: LayoutObject, side targetSide: Side, relation: LayoutRelation, constant: CGFloat) {
        let fromAnchor = side.anchor(for: self)
        let toAnchor = targetSide.anchor(for: target)
        
        constraint(fromAnchor: fromAnchor, toAnchor: toAnchor, relation: relation, constant: constant)
    }
    
}

public extension LayoutObject {
    
    func pinTop(to target: LayoutObject, _ side: VerticalSide = .top, relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(.top, to: target, side: side, relation: relation, constant: constant)
    }
    
    func pinBottom(to target: LayoutObject, _ side: VerticalSide = .bottom, relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(.bottom, to: target, side: side, relation: relation, constant: constant)
    }
    
    func pinLeading(to target: LayoutObject, _ side: HorizontalSide = .leading, relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(.leading, to: target, side: side, relation: relation, constant: constant)
    }
    
    func pinTrailing(to target: LayoutObject, _ side: HorizontalSide = .trailing, relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(.trailing, to: target, side: side, relation: relation, constant: constant)
    }
    
    func pinCenterX(to target: LayoutObject, _ side: HorizontalSide = .centerX, relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(.centerX, to: target, side: side, relation: relation, constant: constant)
    }
    
    func pinCenterY(to target: LayoutObject, _ side: VerticalSide = .centerY, relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(.centerY, to: target, side: side, relation: relation, constant: constant)
    }
    
    func constraintHeight(to target: LayoutObject, _ relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(dimension: heightAnchor, to: target.heightAnchor, relation: relation, constant: constant)
    }
    
    func constraintWidth(to target: LayoutObject, _ relation: LayoutRelation = .equal, constant: CGFloat = 0.0) {
        constraint(dimension: widthAnchor, to: target.widthAnchor, relation: relation, constant: constant)
    }
    
    func constraintHeight(_ relation: LayoutRelation = .equal, to constant: CGFloat = 0.0) {
        constraint(dimension: heightAnchor, to: constant, relation: relation)
    }
    
    func constraintWidth(_ relation: LayoutRelation = .equal, to constant: CGFloat = 0.0) {
        constraint(dimension: widthAnchor, to: constant, relation: relation)
    }
    
}
