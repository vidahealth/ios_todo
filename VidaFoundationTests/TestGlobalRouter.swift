//
//  TestGlobalRouter.swift
//  VidaFoundationTests
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import XCTest
@testable import VidaFoundation

class TestGlobalRouter: XCTestCase {

    var globalRouter: GlobalRouter!

    override func setUp() {
        super.setUp()
        globalRouter = GlobalRouter()
        globalRouter.registerViewControllerClass(UIViewController.self, URLPath: "foo")
        globalRouter.registerViewControllerClass(UIView.self, URLPath: "snaf")

    }

    override func tearDown() {
        super.tearDown()
        globalRouter = nil
    }
    
    func testRendererForURLPath_doesNotExist() {
        XCTAssertNil(globalRouter.viewControllerForURLPath("bar"))
    }

    func testRendererForURLPath_notAViewController() {
        XCTAssertNil(globalRouter.viewControllerForURLPath("snaf"))
    }

    func testRendererForURLPath_exists() {
        XCTAssertNotNil(globalRouter.viewControllerForURLPath("foo"))
    }
    
}
