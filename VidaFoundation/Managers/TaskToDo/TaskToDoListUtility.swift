//
//  TaskToDoListUtility.swift
//  VidaToDo
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

struct TaskToDoListUtility {
    func sortByPriority<T: ToDoTask>(tasks: [T]) -> [T] {
        return tasks.sorted(by: { (left, right) -> Bool in
            return left.priority > right.priority
        })
    }

    func filterByDone<T: ToDoTask>(tasks: [T], priority: ToDoTask.Priority) -> [T] {
        return tasks.filter { $0.done }
    }
} 

