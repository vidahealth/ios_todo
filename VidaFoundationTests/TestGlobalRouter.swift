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
        globalRouter.registerRendererClass(UIViewController.self, URLPath: "foo")
        globalRouter.registerRendererClass(UIView.self, URLPath: "snaf")

    }

    override func tearDown() {
        super.tearDown()
        globalRouter = nil
    }
    
    func testRendererForURLPath_doesNotExist() {
        XCTAssertNil(globalRouter.rendererForURLPath("bar"))
    }

    func testRendererForURLPath_notAViewController() {
        XCTAssertNil(globalRouter.rendererForURLPath("snaf"))
    }

    func testRendererForURLPath_exists() {
        XCTAssertNotNil(globalRouter.rendererForURLPath("foo"))
    }
    
}
