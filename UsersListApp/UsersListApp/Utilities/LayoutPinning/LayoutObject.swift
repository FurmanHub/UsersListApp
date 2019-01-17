import UIKit


public enum LayoutRelation {
    case equal, greaterThanOrEqual, lessThanOrEqual
}

protocol LayoutSide {
    
    associatedtype AnchorType: AnyObject
    
    func anchor(for layoutObject: LayoutObject) -> NSLayoutAnchor<AnchorType>
    
}

public enum VerticalSide {
    case top, bottom, centerY
}

public enum HorizontalSide {
    case leading, trailing, centerX
}

extension HorizontalSide: LayoutSide {
    
    typealias AnchorType = NSLayoutXAxisAnchor
    
    func anchor(for layoutObject: LayoutObject) -> NSLayoutAnchor<AnchorType> {
        switch self {
        case .leading: return layoutObject.leadingAnchor
        case .trailing: return layoutObject.trailingAnchor
        case .centerX: return layoutObject.centerXAnchor
        }
    }
    
}

extension VerticalSide: LayoutSide {
    
    typealias AnchorType = NSLayoutYAxisAnchor
    
    func anchor(for layoutObject: LayoutObject) -> NSLayoutAnchor<AnchorType> {
        switch self {
        case .top: return layoutObject.topAnchor
        case .bottom: return layoutObject.bottomAnchor
        case .centerY: return layoutObject.centerYAnchor
        }
    }
    
}

public protocol LayoutObject {
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var leftAnchor: NSLayoutXAxisAnchor { get }
    
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    
    var heightAnchor: NSLayoutDimension { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
}
