//
//  UIViewController+TopController.swift
//  Vida
//
//  Created by Vasyl Khmil on 4/4/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import UIKit

// topController property return the highest controller in hierarchy that might be visible.
// Is useful in case you need the correct controller for presentation of your content.
// It enumerate through UITabBarControllers, UINavigationControllers & presented UIViewController

extension UIViewController {

    var topController: UIViewController {
        return topViewController(from: self) ?? self
    }

    fileprivate func topViewController(from rootViewController: UIViewController?) -> UIViewController? {

        if let childViewController = rootViewController?.childViewControllers.first {
            return topViewController(from:childViewController)
        }
        else {
            return rootViewController
        }
    }
}
