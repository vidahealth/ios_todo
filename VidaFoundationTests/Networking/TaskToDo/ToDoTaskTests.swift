//
//  ToDoTaskTests.swift
//  VidaFoundationTests
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import XCTest
@testable import VidaFoundation

class ToDoTaskTests: XCTestCase {

    // MARK: Test ToDoTask
    func testToDoTaskPriorityEqual_low() {
        let left = ToDoTask.Priority.low
        let right = ToDoTask.Priority.low
        let isEqual: Bool = left == right
        XCTAssertTrue(isEqual)
    }

    func testToDoTaskPriorityEqual_medium() {
        let left = ToDoTask.Priority.medium
        let right = ToDoTask.Priority.medium
        let isEqual: Bool = left == right
        XCTAssertTrue(isEqual)
    }

    func testToDoTaskPriorityEqual_high() {
        let left = ToDoTask.Priority.high
        let right = ToDoTask.Priority.high
        let isEqual: Bool = left == right
        XCTAssertTrue(isEqual)
    }

    func testToDoTaskPriorityEqualCompare_equal() {
        let left = ToDoTask.Priority.high
        let right = ToDoTask.Priority.high
        let isEqual: Bool = left <= right
        XCTAssertTrue(isEqual)
    }

    func testToDoTaskPriorityComparable_equal_low() {
        let left = ToDoTask.Priority.low
        let right = ToDoTask.Priority.low
        let isLeftLower: Bool = left < right
        XCTAssertFalse(isLeftLower)
    }

    func testToDoTaskPriorityComparable_equal_medium() {
        let left = ToDoTask.Priority.medium
        let right = ToDoTask.Priority.medium
        let isLeftLower = left < right
        XCTAssertFalse(isLeftLower)
    }

    func testToDoTaskPriorityComparable_equal_high() {
        let left = ToDoTask.Priority.high
        let right = ToDoTask.Priority.high
        let isLeftLower = left < right
        XCTAssertFalse(isLeftLower)
    }

    func testToDoTaskPriorityComparable_compare_low_med() {
        let left = ToDoTask.Priority.low
        let right = ToDoTask.Priority.medium
        let isLeftLower = left < right
        XCTAssertTrue(isLeftLower)
    }

    func testToDoTaskPriorityComparable_compare_low_high() {
        let left = ToDoTask.Priority.low
        let right = ToDoTask.Priority.high
        let isLeftLower = left < right
        XCTAssertTrue(isLeftLower)
    }

    func testToDoTaskPriorityComparable_compare_med_low() {
        let left = ToDoTask.Priority.medium
        let right = ToDoTask.Priority.low
        let isLeftLower = left < right
        XCTAssertFalse(isLeftLower)
    }

    func testToDoTaskPriorityComparable_compare_med_high() {
        let left = ToDoTask.Priority.medium
        let right = ToDoTask.Priority.high
        let isLeftLower = left < right
        XCTAssertTrue(isLeftLower)
    }

    func testToDoTaskPriorityComparable_compare_high_low() {
        let left = ToDoTask.Priority.high
        let right = ToDoTask.Priority.low
        let isLeftLower = left < right
        XCTAssertFalse(isLeftLower)
    }

    func testToDoTaskPriorityComparable_compare_high_med() {
        let left = ToDoTask.Priority.high
        let right = ToDoTask.Priority.medium
        let isLeftLower = left < right
        XCTAssertFalse(isLeftLower)
    }
}

