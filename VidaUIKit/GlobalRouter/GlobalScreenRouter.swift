//
//  GlobalRouter.swift
//  VidaFoundation
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit

public protocol Routable where Self: UIViewController {
    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController?
}

/// The Screen Router is responsible for providing fully initialized, view controller objects for a GlobalScreenURL
/// View Renderers (View Controllers) contact the ScreenRouter to get the proper view controller and then choose independently how to
/// transitino to that new view controller.
public protocol ScreenRouter {

    /// Registers a view controller class with a GlobalScreenURL
    func registerViewControllerClass(_ viewControllerClass: AnyClass, screenURL: GlobalScreenURL)

    /// Provides a fully initialized view controller given a GlobalScreenURL ready to be presented
    func viewControllerForURLPath(_ screenURL: GlobalScreenURL) -> UIViewController?

}

public class GlobalScreenRouter: ScreenRouter {
    public static let shared = GlobalScreenRouter()

    fileprivate var viewControllerURLMap = [GlobalScreenURL: AnyClass]() // URL -> rendererClass

    fileprivate init() {}

    public func registerViewControllerClass(_ viewControllerClass: AnyClass, screenURL: GlobalScreenURL) {
        viewControllerURLMap[screenURL] = viewControllerClass
    }

    public func viewControllerForURLPath(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard let viewControllerClass = viewControllerURLMap[screenURL] as? UIViewController.Type else {
            fatalLog("Unable find view controller for URL: \(screenURL)")
            return nil
        }

        guard let routableClass = viewControllerClass as? Routable.Type else {
            fatalLog("View Controller does not conform to routable for URL: \(screenURL), view controller: \(viewControllerClass)")
            return nil
        }

        return routableClass.makeWithURL(screenURL)
    }
}
