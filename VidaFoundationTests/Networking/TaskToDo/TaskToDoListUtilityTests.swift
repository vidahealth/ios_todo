//
//  VidaToDoTests.swift
//  VidaToDoTests
//
//  Created by Brice Pollock on 4/17/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import XCTest
@testable import VidaFoundation

class TaskToDoListUtilityTests: XCTestCase {
    let utility = TaskToDoListUtility()

    func createTask(title: String, priority: ToDoTask.Priority = .low, isDone: Bool = false) -> ToDoTask {
        return ToDoTask(id: 0, group: nil, title: title, description: nil, priority: priority, done: isDone)
    }

    // MARK: sortByPriority
    func testSortPriority_empty() {
        let tasks = [ToDoTask]()
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertTrue(result.isEmpty)
    }

    func testSortPriority_single() {
        let tasks = [
            createTask(title:"one")
        ]
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertFalse(result.isEmpty)
    }

    func testSortPriority_double_inOrder() {
        let tasks = [
            createTask(title:"one", priority: .medium),
            createTask(title:"two", priority: .low)
        ]
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertEqual(result.first?.title, "one")
    }

    func testSortPriority_double_outOrder() {
        let tasks = [
            createTask(title:"one", priority: .low),
            createTask(title:"two", priority: .medium)
        ]
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertEqual(result.first?.title, "two")
    }

    func testSortPriority_double_same() {
        let tasks = [
            createTask(title:"one", priority: .low),
            createTask(title:"two", priority: .low)
        ]
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertEqual(result.first?.title, "one")
    }

    func testSortPriority_triple_middleFirst() {
        let tasks = [
            createTask(title:"one", priority: .low),
            createTask(title:"two", priority: .high),
            createTask(title:"three", priority: .medium)
        ]
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertEqual(result.first?.title, "two")
    }

    func testSortPriority_triple_lastFirst() {
        let tasks = [
            createTask(title:"one", priority: .medium),
            createTask(title:"two", priority: .low),
            createTask(title:"three", priority: .high)
        ]
        let result = utility.sortByPriority(tasks: tasks)
        XCTAssertEqual(result.first?.title, "three")
    }

    // MARK: filterByDone
    func testFilterByDone_empty() {
        let tasks = [ToDoTask]()
        let result = utility.filterByDone(tasks: tasks, priority: .high)
        XCTAssertTrue(result.isEmpty)
    }

    func testFilterByDone_single_done() {
        let tasks = [
            createTask(title:"one", isDone: true)
        ]

        let result = utility.filterByDone(tasks: tasks, priority: .high)
        XCTAssertFalse(result.isEmpty)
    }

    func testFilterByDone_single_notDone() {
        let tasks = [
            createTask(title:"one", isDone: false)
        ]

        let result = utility.filterByDone(tasks: tasks, priority: .high)
        XCTAssertTrue(result.isEmpty)
    }

    func testFilterByDone_double_mixed() {
        let tasks = [
            createTask(title:"one", isDone: false),
            createTask(title:"two", isDone: true)
        ]

        let result = utility.filterByDone(tasks: tasks, priority: .high)
        XCTAssertEqual(result.first?.title, "two")
    }

}
