//
//  GlobalRouter.swift
//  VidaFoundation
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit

// Brice: Needs documentation
// TODO: think about hame conflict with Vida App
// TODO: Move to UIKit

public protocol Router {

    // Register consumers for URLs

    // TODO GlobalURL
    func registerViewControllerClass(_ consumer: AnyClass, URLPath: String)

    func viewControllerForURLPath(_ URLPath: String) -> UIViewController?

}

// BRICE: Technically belongs in VidaUIKit since refrences UIViewCOntroler
class GlobalRouter: Router {
    static let shared = GlobalRouter()

    fileprivate var viewControllerURLMap = [String: AnyClass]() // URL -> rendererClass

    fileprivate init() {}

    func registerViewControllerClass(_ viewControllerClass: AnyClass, URLPath: String) {
        viewControllerURLMap[URLPath] = viewControllerClass
    }

    func viewControllerForURLPath(_ URLPath: String) -> UIViewController? {
        guard let viewControllerClass = viewControllerURLMap[URLPath] as? UIViewController.Type else {
            errorLog("Unable find view controller for URL: \(URLPath)")
            return nil
        }

        // Brice: I think we need a custom protocol init method that takes in the url to properly innitialize this and return a satisfied VC

        // makeWithURL initialization


        return viewControllerClass.init()
    }
}
