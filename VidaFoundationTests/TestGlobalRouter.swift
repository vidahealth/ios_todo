//
//  TestGlobalRouter.swift
//  VidaFoundationTests
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import XCTest
@testable import VidaFoundation

class MockTabViewController: UITabBarController, Routable {
    
    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard case .tab = screenURL else {
            fatalLog("Invalid URL passed to view controller: \(self)")
            return nil
        }
        return MockTabViewController()
    }
}

class TestGlobalRouter: XCTestCase {

    var router: GlobalScreenRouter!

    override func setUp() {
        super.setUp()
        router = GlobalScreenRouter()
        router.registerViewControllerClass(MockTabViewController.self, screenURL: .tab)
        router.registerViewControllerClass(UIView.self, screenURL: .toDoList)

    }

    override func tearDown() {
        super.tearDown()
        router = nil
    }
    
    func testRendererForURLPath_doesNotExist() {
        XCTAssertNil(router.viewControllerForURLPath(.settings))
    }

    func testRendererForURLPath_notAViewController() {
        XCTAssertNil(router.viewControllerForURLPath(.toDoList))
    }

    func testRendererForURLPath_exists() {
        XCTAssertNotNil(router.viewControllerForURLPath(.tab))
    }
    
}
