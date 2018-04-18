//
//  GlobalRouter.swift
//  VidaFoundation
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit

public var SharedGlobalRouter: Router {
    struct Singleton {
        static let instance = GlobalRouter()
    }
    return Singleton.instance
}

public protocol Router {

    // Register consumers for URLs
    func registerViewControllerClass(_ consumer: AnyClass, URLPath: String)

    func viewControllerForURLPath(_ URLPath: String) -> UIViewController?

}

class GlobalRouter: Router {

    fileprivate var viewControllerURLMap = [String: AnyClass]() // URL -> rendererClass

    func registerViewControllerClass(_ viewControllerClass: AnyClass, URLPath: String) {
        viewControllerURLMap[URLPath] = viewControllerClass
    }

    func viewControllerForURLPath(_ URLPath: String) -> UIViewController? {
        guard let viewControllerClass = viewControllerURLMap[URLPath] as? UIViewController.Type else {
            errorLog("Unable find view controller for URL: \(URLPath)")
            return nil
        }

        return viewControllerClass.init()
    }
}
