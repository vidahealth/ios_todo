//
//  TaskToDoListUtility.swift
//  VidaToDo
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import VidaFoundation

struct TaskToDoListUtility {
    func sortByPriority(tasks: [ToDoTask]) -> [ToDoTask] {
        return tasks.sorted(by: { (left, right) -> Bool in
            return left.priority > right.priority
        })
    }

    func filterByDone(tasks: [ToDoTask], priority: ToDoTask.Priority) -> [ToDoTask] {
        return tasks.filter { $0.done }
    }
}

