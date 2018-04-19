//
//  UIViewController+create.swift
//  Brice Pollock
//
//  Created by Brice Pollock on 11/28/16.
//  Copyright © 2016 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    static func createInstanceFromStoryboard<T: UIViewController>(storyboardName: String? = nil) -> T {
        let viewControllerString = String(describing: T.self)
        let viewControllerBundle = Bundle(for: T.self)
        let storyboardName = storyboardName ?? viewControllerString
        let storyboard = UIStoryboard(name: storyboardName, bundle: viewControllerBundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerString) as? T else {
            print("Unable to load \(viewControllerString) from storyboard")
            return T()
        }
        return viewController
    }
}
