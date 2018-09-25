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
    
    func testStorage_createString() {
        let foo = "bar"
        storage.set(foo, forKey: "foo")
        XCTAssertEqual(foo, storage.object(forKey: "foo"))
    }

    func testStorage_createArray() {
        let foo = ["bar"]
        storage.set(foo, forKey: "foo")
        XCTAssertEqual(foo, storage.object(forKey: "foo"))
    }

    func testStorage_createToDoList() {
        let foo:ToDoTask = ToDoTask(id: 1,
                           group: "bar",
                           title: "foo",
                           description: "poo",
                           priority: .low,
                           done: false)
        do {
            let encodeFoo = try JSONEncoder().encode(foo)
            storage.set(encodeFoo, forKey: "foo")
            let codedTask: Data? = storage.object(forKey: "foo")

            do {
                let decodedTask: ToDoTask = try JSONDecoder().decode(ToDoTask.self, from: codedTask!)
                XCTAssertEqual(foo.group, decodedTask.group)
            } catch {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }

    func testStorage_remove() {
        let foo = "bar"
        storage.set(foo, forKey: "foo")
        storage.removeObject(forKey: "foo")
        let storedObject: String? = storage.object(forKey: "foo")
        XCTAssertNil(storedObject)
    }
    
}
