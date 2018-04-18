//
//  TestStorage.swift
//  VidaFoundationTests
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import XCTest
@testable import VidaFoundation

class TestStorage: XCTestCase {

    var storage: GlobalStorage!
    
    override func setUp() {
        super.setUp()
        storage = GlobalStorage()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStorage_create() {
        let foo = "bar"
        storage.set(foo, forKey: "foo")
        XCTAssertEqual(foo, storage.object(forKey: "foo"))
    }

    func testStorage_remove() {
        let foo = "bar"
        storage.set(foo, forKey: "foo")
        storage.removeObject(forKey: "foo")
        XCTAssertNil(storage.object(forKey: "foo"))
    }
    
}
