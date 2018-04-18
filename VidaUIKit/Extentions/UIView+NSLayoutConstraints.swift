//  Created by Axel Ancona Esselmann on 11/4/16.
//  Copyright © 2016 Vida. All rights reserved.
//

import UIKit

public protocol LayoutConstraintWrapper {

}

enum RelativeLayoutConstraintPriority: Float {
    case lowest  = 1.0
    case low     = 250.0
    case medium  = 500.0
    case high    = 750.0
    case highest = 1000.0
}

enum LayoutConstraintIdentifier: String {
    case toTopOfSuperview    = "toTopOfSuperview"
    case toBottomOfSuperview = "toBottomOfSuperview"
    case firstElementLeading = "firstElementLeading"
    case lastElementTrailing = "lastElementTrailing"
    case firstElementTop     = "firstElementTop"
    case firstElementBottom  = "firstElementBottom"
}

public enum Axis {
    case vertical
    case horizontal
}

extension LayoutConstraintWrapper {
    private var view: UIView {
        return self as! UIView
    }

    @discardableResult
    public func align(
        _ ownAttribute: NSLayoutAttribute,
        to otherAttribute: NSLayoutAttribute,
        of other: UIView,
        withPadding constant: Double = 0.0
        ) -> NSLayoutConstraint {
        let constraint = getConstraintToAlign(ownAttribute, to: otherAttribute, of: other, withPadding: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    @discardableResult
    public func scale(
        _ ownAttribute: NSLayoutAttribute,
        to otherAttribute: NSLayoutAttribute,
        of other: UIView,
        withMultiplier multiplier: Double,
        withPadding constant: Double = 0.0
        ) -> NSLayoutConstraint {
        let constraint = getConstraintToScale(ownAttribute, to: otherAttribute, of: other, withMultiplier: multiplier, withPadding: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    @discardableResult
    public func align(below topView: UIView, withPadding constant: Double = 0.0) -> Self {
        align(.top, to: .bottom, of: topView, withPadding: constant)
        align(.leading, to: .leading, of: topView)
        return self
    }

    @discardableResult
    public func alignWithEqualWidth(below topView: UIView, withPadding constant: Double = 0.0) -> Self {
        align(below: topView, withPadding: constant)
        align(.width, to: .width, of: topView)
        return self
    }

    public func getConstraintToAlign(
        _ ownAttribute: NSLayoutAttribute,
        to otherAttribute: NSLayoutAttribute,
        of other: UIView,
        withPadding constant: Double = 0.0
        ) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(
            item:       self,
            attribute:  ownAttribute,
            relatedBy:  .equal,
            toItem:     other,
            attribute:  otherAttribute,
            multiplier: 1.0,
            constant:   CGFloat(constant)
        )
    }

    public func getConstraintToScale(
        _ ownAttribute: NSLayoutAttribute,
        to otherAttribute: NSLayoutAttribute,
        of other: UIView,
        withMultiplier multiplier: Double,
        withPadding constant: Double = 0.0
        ) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(
            item:       self,
            attribute:  ownAttribute,
            relatedBy:  .equal,
            toItem:     other,
            attribute:  otherAttribute,
            multiplier: CGFloat(multiplier),
            constant:   CGFloat(constant)
        )
    }

    public func getConstraintForHeight(_ height: CGFloat) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
    }

    public func height(_ height: CGFloat) {
        let heightConstraint = getConstraintForHeight(height)
        NSLayoutConstraint.activate([heightConstraint])
    }

    @discardableResult public func height(_ height: Double) -> NSLayoutConstraint {
        let heightConstraint = getConstraintForHeight(CGFloat(height))
        NSLayoutConstraint.activate([heightConstraint])

        return heightConstraint
    }

    public func getConstraintForWidth(_ width: CGFloat) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
    }

    @discardableResult
    public func width(_ width: CGFloat) -> NSLayoutConstraint  {
        let widthConstraint = getConstraintForWidth(width)
        NSLayoutConstraint.activate([widthConstraint])
        return widthConstraint
    }

    @discardableResult
    public func width(_ width: Double) -> NSLayoutConstraint {
        let widthConstraint = getConstraintForWidth(CGFloat(width))
        NSLayoutConstraint.activate([widthConstraint])
        return widthConstraint
    }

    @discardableResult public func size(width: Double, height: Double) -> Self {
        self.width(width)
        self.height(height)
        return self
    }

    @discardableResult public func size(width: CGFloat, height: CGFloat) -> Self {
        self.width(width)
        self.height(height)
        return self
    }

    public func top(toBottomOf target: UIView, withPadding constant: Double = 0.0) {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: target, attribute: .bottom, multiplier: 1.0, constant: CGFloat(constant))
        NSLayoutConstraint.activate([constraint])
    }

    public func top(toTopOf target: UIView, withPadding constant: Double = 0.0) {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: target, attribute: .top, multiplier: 1.0, constant: CGFloat(constant))
        NSLayoutConstraint.activate([constraint])
    }

    @discardableResult public func left(_ padding: Double = 0) -> Self {
        if let superview = view.superview {
            align(.leading, to: .leading, of: superview, withPadding: padding)
        }
        return self
    }

    @discardableResult public func right(_ padding: Double = 0) -> Self {
        if let superview = view.superview {
            align(.trailing, to: .trailing, of: superview, withPadding: -padding)
        }
        return self
    }

    /**
     Bottom layout constraint helper public function.
     - note: If working with safe areas on iPhone X, refer to **bottomSafe()**
     */
    @discardableResult public func bottom(_ padding: Double = 0) -> Self {
        if let superview = view.superview {
            align(.bottom, to: .bottom, of: superview, withPadding: -padding)
        }
        return self
    }

    /**
     Top layout constraint helper public function.
     - note: If working with safe areas on iPhone X, refer to **topSafe()**
     */
    @discardableResult public func top(_ padding: Double = 0) -> Self {
        if let superview = view.superview {
            align(.top, to: .top, of: superview, withPadding: padding)
        }
        return self
    }


    /**
     Top layout constraint helper public function that takes safe areas into consideration.
     * Use this when you want a top view to appear below the top notch on the iPhone X.
     * If device is not an iPhone X, then whether or not it's at least an iOS 11 device, it will behave the same as `.top(padding)`
     ## Reference
     [Positioning Content Relative to the Safe Area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area?language=objc)
     */
    @discardableResult
    public func topSafe(_ padding: Double = 0) -> Self {
        guard let superview = view.superview else {
            return self
        }
        if #available(iOS 11.0, *) {
            view.translatesAutoresizingMaskIntoConstraints = false
            let topAnchor = superview.safeAreaLayoutGuide.topAnchor
            let topConstraint = view.topAnchor.constraintEqualToSystemSpacingBelow(topAnchor, multiplier: 1.0)
            topConstraint.constant = CGFloat(padding)
            NSLayoutConstraint.activate([topConstraint])
        } else {
            align(.top, to: .top, of: superview, withPadding: padding)
        }
        return self
    }

    /**
     Bottom layout constraint helper public function that takes safe areas into consideration.
     * Use this when you want a bottom view to appear above the bottom microphone on the iPhone X.
     * If device is not an iPhone X, then whether or not it's at least an iOS 11 device, it will behave the same as `.bottom(padding)`
     ## Reference
     [Positioning Content Relative to the Safe Area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area?language=objc)
     */
    @discardableResult
    public func bottomSafe(_ padding: Double = 0) -> Self {
        guard let superview = view.superview else {
            return self
        }
        if #available(iOS 11.0, *) {
            view.translatesAutoresizingMaskIntoConstraints = false
            let bottomAnchor = superview.safeAreaLayoutGuide.bottomAnchor
            let bottomConstraint = view.bottomAnchor.constraintEqualToSystemSpacingBelow(bottomAnchor, multiplier: 1.0)
            bottomConstraint.constant = CGFloat(padding)
            NSLayoutConstraint.activate([bottomConstraint])
        } else {
            align(.bottom, to: .bottom, of: superview, withPadding: padding)
        }
        return self
    }

    @discardableResult public func center(_ orientation: Axis? = nil) -> Self {
        if let superview = view.superview {
            switch orientation {
            case .some(.horizontal): align(.centerX, to: .centerX, of: superview)
            case .some(.vertical):   align(.centerY, to: .centerY, of: superview)
            default:
                align(.centerX, to: .centerX, of: superview)
                align(.centerY, to: .centerY, of: superview)
            }
        }
        return self
    }

    public func fillWidthOfSuperview(withPadding padding: Double = 0.0) {
        if let horizontalConstraints = view.superview?.getConstraintsForHorizontalEdges(
            view,
            withPadding: padding
            ) {
            view.superview?.addConstraints(horizontalConstraints)
        }
    }

    public func fillHeightOfSuperview() {
        if let verticalConstraints = view.superview?.getConstraintsForVerticalEdges(view) {
            view.superview?.addConstraints(verticalConstraints)
        }
    }

    public func fillSuperview() {
        view.translatesAutoresizingMaskIntoConstraints = false
        fillWidthOfSuperview()
        fillHeightOfSuperview()
    }

    public func fill(superView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(
            item: self,
            attribute: .left,
            relatedBy: .equal,
            toItem: superView,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0
        )
        let top = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: superView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0
        )
        let width = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: superView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0
        )
        let height = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: superView,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0
        )
        superView.addConstraints([left, top, height, width])
    }

    public func centerHorizontally() {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .centerX,
            relatedBy: .equal,
            toItem:     view.superview,
            attribute: .centerX,
            multiplier: 1.0,
            constant:   0
        )
        NSLayoutConstraint.activate([constraint])
    }

    public func centerVertically() {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .centerY,
            relatedBy: .equal,
            toItem:     view.superview,
            attribute: .centerY,
            multiplier: 1.0,
            constant:   0
        )
        NSLayoutConstraint.activate([constraint])
    }

    public func centerOrFillHorizontally() {
        for constraint in view.constraints {
            if constraint.firstAttribute == .width {
                centerHorizontally()
                return
            }
        }
        fillWidthOfSuperview()
    }

    public func alignSubViewsVertically(_ subViews: [UIView], withPadding constant: Double = 0.0) {
        var prevSubView = subViews.first!
        prevSubView.centerOrFillHorizontally()
        prevSubView.translatesAutoresizingMaskIntoConstraints = false
        let toTopOvView = prevSubView.getConstraintToAlign(.top, to: .top, of: view)
        toTopOvView.identifier = LayoutConstraintIdentifier.toTopOfSuperview.rawValue
        for index in 1..<subViews.count {
            let current = subViews[index]
            current.translatesAutoresizingMaskIntoConstraints = false
            let toPrevView = current.layout.getConstraintToAlign(
                .top, to: .bottom, of: prevSubView, withPadding: constant
            )
            toPrevView.priority = UILayoutPriority(rawValue: RelativeLayoutConstraintPriority.highest.rawValue)
            NSLayoutConstraint.activate([toPrevView])
            current.centerOrFillHorizontally()
            prevSubView = current
        }

        NSLayoutConstraint.activate([toTopOvView])
    }

    public func alignSubViewsVerticallyFilling(_ subViews: [UIView], withPadding constant: Double = 0.0) {
        alignSubViewsVertically(subViews, withPadding: constant)
        let toBottomOfView = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: subViews.last!, attribute: .bottom, multiplier: 1.0, constant: 0)
        toBottomOfView.identifier = LayoutConstraintIdentifier.toBottomOfSuperview.rawValue
        toBottomOfView.priority   = UILayoutPriority(rawValue: RelativeLayoutConstraintPriority.low.rawValue)
        NSLayoutConstraint.activate([toBottomOfView])
    }

    @discardableResult
    static public func align(vertically views: [UIView], padding: Double = 0.0) -> [NSLayoutConstraint] {
        guard let first = views.first else { return [] }
        var constraints: [NSLayoutConstraint] = []
        var previous = first
        for index in 1..<views.count {
            let current = views[index]
            constraints.append(current.layout.align(.top, to: .bottom, of: previous, withPadding: padding))
            previous = current
        }
        return constraints
    }

    @discardableResult
    static public func align(vertically views: UIView... , withPadding padding: Double = 0.0) -> [NSLayoutConstraint] {
        return align(vertically: views, padding: padding)
    }

    @discardableResult
    static public func align(horizontally views: [UIView], padding: Double = 0.0) -> [NSLayoutConstraint] {
        guard let first = views.first else { return [] }
        var constraints: [NSLayoutConstraint] = []
        var previous = first
        for index in 1..<views.count {
            let current = views[index]
            constraints.append(current.layout.align(.leading, to: .trailing, of: previous, withPadding: padding))
            previous = current
        }
        return constraints
    }

    @discardableResult
    static public func align(horizontally views: UIView... , withPadding padding: Double = 0.0) -> [NSLayoutConstraint] {
        return align(horizontally: views, padding: padding)
    }

    @discardableResult
    static public func setEqual(layoutAttribute: NSLayoutAttribute, for views: UIView...) -> [NSLayoutConstraint] {
        return setEqual(layoutAttribute: layoutAttribute, for: views)
    }

    @discardableResult
    static public func setEqual(layoutAttribute: NSLayoutAttribute, for views: [UIView]) -> [NSLayoutConstraint] {
        guard let first = views.first else { return [] }
        var constraints: [NSLayoutConstraint] = []
        var previous = first
        for index in 1..<views.count {
            let current = views[index]
            constraints.append(current.layout.align(layoutAttribute, to: layoutAttribute, of: previous))
            previous = current
        }
        return constraints
    }

    @discardableResult
    static public func setEqual(layoutAttributes: [NSLayoutAttribute], for views: [UIView]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        for layoutAttribute in layoutAttributes {
            constraints += setEqual(layoutAttribute: layoutAttribute, for: views)
        }
        return constraints
    }

    @discardableResult
    static public func setEqual(layoutAttributes: [NSLayoutAttribute], for views: UIView...) -> [NSLayoutConstraint] {
        return setEqual(layoutAttributes: layoutAttributes, for: views)
    }

    public func addSubviews(_ views: [UIView]) {
        for view in views {
            self.view.addSubview(view)
        }
    }

    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }

    static public func apply(constants: [Int: Double], to constraints: [NSLayoutConstraint]) {
        for (index, constant) in constants {
            guard index < constraints.count else { continue }
            constraints[index].constant = CGFloat(constant)
        }
    }

    static public func apply(constant: Double, at indices: [Int], to constraints: [NSLayoutConstraint]) {
        for index in indices {
            guard index < constraints.count else { continue }
            constraints[index].constant = CGFloat(constant)
        }
    }

    public static var layout: UIView.Type {
        return UIView.self
    }

    @discardableResult
    static public func horizontalContainerView(for views: [UIView], spacing: Double = 0.0) -> UIView {
        let container = UIView()
        container.addSubviews(views)
        layout.setEqual(layoutAttribute: .centerY, for: views)
        align(horizontally: views, padding: spacing)
        if let firstView = views.first {
            firstView.align(.leading, to: .leading, of: container)
            firstView.align(.top, to: .top, of: container)
            firstView.align(.bottom, to: .bottom, of: container)
        }
        if let lastView = views.last {
            lastView.align(.trailing, to: .trailing, of: container)
        }
        return container
    }

    @discardableResult
    static public func horizontalContainerView(for views: UIView... , withSpacing spacing: Double = 0.0) -> UIView {
        return horizontalContainerView(for: views, spacing: spacing)
    }

    @discardableResult
    static public func verticalContainerView(for views: [UIView], spacing: Double = 0.0) -> UIView {
        let container = UIView()
        container.addSubviews(views)
        layout.setEqual(layoutAttribute: .centerX, for: views)
        align(vertically: views, padding: spacing)
        if let firstView = views.first {
            firstView.align(.top, to: .top, of: container)
            firstView.align(.leading, to: .leading, of: container)
            firstView.align(.trailing, to: .trailing, of: container)
        }
        if let lastView = views.last {
            lastView.align(.bottom, to: .bottom, of: container)
        }
        return container
    }

    @discardableResult
    static public func verticalContainerView(for views: UIView... , withSpacing spacing: Double = 0.0) -> UIView {
        return verticalContainerView(for: views, spacing: spacing)
    }

    public func center(in view: UIView) {
        align(.centerX, to: .centerX, of: view)
        align(.centerY, to: .centerY, of: view)
    }
}

extension UIView: LayoutConstraintWrapper {

    public var layout: LayoutConstraintWrapper {
        return self
    }

    public func copyConstraintsFrom(_ otherView:UIView, deactivateOriginalConstraints:Bool = true) {
        frame = otherView.frame
        autoresizingMask = otherView.autoresizingMask
        translatesAutoresizingMaskIntoConstraints = otherView.translatesAutoresizingMaskIntoConstraints
        for constraint in otherView.constraints {
            let firstItem = constraint.firstItem === otherView ? self : constraint.firstItem
            let secondItem = constraint.secondItem === otherView ? self : constraint.secondItem
            let firstItemAsAny = firstItem as Any
            addConstraint(NSLayoutConstraint(item: firstItemAsAny, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
            if firstItem === self || secondItem === self {
                if deactivateOriginalConstraints {
                    NSLayoutConstraint.deactivate([constraint])
                }
            }
        }
    }

    public func getConstraintsForVerticalEdges(_ subview: UIView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let top = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem:     subview,
            attribute: .top,
            multiplier: 1.0,
            constant:   0
        )
        let bottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem:     subview,
            attribute: .bottom,
            multiplier: 1.0,
            constant:   0
        )
        constraints.append(top)
        constraints.append(bottom)
        return constraints
    }
    public func getConstraintsForHorizontalEdges(_ subview: UIView, withPadding padding: Double = 0) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let left = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem:     subview,
            attribute: .leading,
            multiplier: 1.0,
            constant:   CGFloat(-padding)
        )
        let right = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem:     subview,
            attribute: .trailing,
            multiplier: 1.0,
            constant:   CGFloat(padding)
        )
        constraints.append(left)
        constraints.append(right)
        return constraints
    }
    public func getConstrainsForVerticallyContainedElements(_ elements: [UIView], with spacing: Double = 0.0) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        guard elements.count > 0 else {
            return constraints
        }
        var prevElement = elements.first!
        prevElement.translatesAutoresizingMaskIntoConstraints = false

        let firstElementleft = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem:     elements.first,
            attribute: .leading,
            multiplier: 1.0,
            constant:   0
        )
        let firstElementRight = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem:     elements.first,
            attribute: .trailing,
            multiplier: 1.0,
            constant:   0
        )
        let firstElementTop = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem:     elements.first,
            attribute: .top,
            multiplier: 1.0,
            constant:   0
        )
        let lastElementBottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .lessThanOrEqual,
            toItem:     elements.last,
            attribute: .bottom,
            multiplier: 1.0,
            constant:   0
        )

        constraints.append(firstElementleft)
        constraints.append(firstElementTop)

        if !translatesAutoresizingMaskIntoConstraints {
            constraints.append(firstElementRight)
        }
        constraints.append(lastElementBottom)

        for index in stride(from: 1, to: elements.count, by: 1) {
            elements[index].translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(
                item: prevElement,
                attribute: .bottom,
                relatedBy: .equal,
                toItem:     elements[index],
                attribute: .top,
                multiplier: 1.0,
                constant:   CGFloat(-spacing)
            )
            let center = NSLayoutConstraint(
                item: prevElement,
                attribute: .centerX,
                relatedBy: .equal,
                toItem:     elements[index],
                attribute: .centerX,
                multiplier: 1.0,
                constant:   0
            )
            let width = NSLayoutConstraint(
                item: prevElement,
                attribute: .width,
                relatedBy: .equal,
                toItem:     elements[index],
                attribute: .width,
                multiplier: 1.0,
                constant:   0
            )
            constraints.append(top)
            constraints.append(center)
            constraints.append(width)
            prevElement = elements[index]
        }
        return constraints
    }

    public func getConstrainsForHorizontalyContainedElements(_ elements: [UIView], with spacing: Double = 0.0) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        guard elements.count > 0 else {
            return constraints
        }
        var prevElement = elements.first!
        prevElement.translatesAutoresizingMaskIntoConstraints = false

        let firstElementleft = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem:     elements.first,
            attribute: .leading,
            multiplier: 1.0,
            constant:   0
        )
        firstElementleft.identifier = LayoutConstraintIdentifier.firstElementLeading.rawValue
        let lastElementRight = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem:     elements.last,
            attribute: .trailing,
            multiplier: 1.0,
            constant:   0
        )
        lastElementRight.identifier = LayoutConstraintIdentifier.lastElementTrailing.rawValue
        let firstElementTop = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem:     elements.first,
            attribute: .top,
            multiplier: 1.0,
            constant:   0
        )
        firstElementTop.identifier = LayoutConstraintIdentifier.firstElementTop.rawValue
        let firstElementBottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .greaterThanOrEqual,
            toItem:     elements.first!,
            attribute: .bottom,
            multiplier: 1.0,
            constant:   0
        )
        firstElementBottom.identifier = LayoutConstraintIdentifier.firstElementBottom.rawValue
        let firstElementAspect = getAspectRatioConstraint(for: elements.first!)

        constraints.append(firstElementleft)
        constraints.append(firstElementTop)
        constraints.append(lastElementRight)
        if !translatesAutoresizingMaskIntoConstraints {
            constraints.append(firstElementBottom)
        }
        constraints.append(firstElementAspect)

        for index in stride(from: 1, to: elements.count, by: 1) {
            elements[index].translatesAutoresizingMaskIntoConstraints = false
            let left = NSLayoutConstraint(
                item: prevElement,
                attribute: .trailing,
                relatedBy: .equal,
                toItem:     elements[index],
                attribute: .leading,
                multiplier: 1.0,
                constant:   CGFloat(-spacing)
            )
            let center = NSLayoutConstraint(
                item: prevElement,
                attribute: .centerY,
                relatedBy: .equal,
                toItem:     elements[index],
                attribute: .centerY,
                multiplier: 1.0,
                constant:   0
            )
            let aspect = getAspectRatioConstraint(for: elements[index])
            let height = NSLayoutConstraint(
                item: prevElement,
                attribute: .height,
                relatedBy: .equal,
                toItem:     elements[index],
                attribute: .height,
                multiplier: 1.0,
                constant:   0
            )
            constraints.append(left)
            constraints.append(center)
            constraints.append(aspect)
            constraints.append(height)
            prevElement = elements[index]
        }
        return constraints
    }

    public func getAspectRatioConstraint(for element: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: element,
            attribute: .height,
            relatedBy: .equal,
            toItem: element,
            attribute: .width,
            multiplier: element.frame.height / element.frame.height,
            constant: 0
        )
    }
}
