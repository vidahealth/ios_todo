//
//  TaskToDoManager.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift

public struct TaskToDoManager {
    let service = TaskToDoService()
    let utility = TaskToDoListUtility()

    public init() {}

    public func tasks() -> Observable<[ToDoTask]> {
        return service.tasks().map({ (result) -> [ToDoTask] in
            guard case .value(let tasks) = result else {
                return []
            }

            return self.utility.sortByPriority(tasks: tasks)
        })
    }

    public func createTask(_ task: LocalToDoTask) -> Observable<Result<Bool>> {
        return service.createTask(task)
    }

    public func updateTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
        return service.updateTask(task)
    }

    public func deleteTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
        return service.updateTask(task)
    }
}
