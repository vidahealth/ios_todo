//
//  ToDoService.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift

struct ToDoTask {

}

// TODO: Think about creating a Service
//GET /todos?group=[groupname]
//[
//    {
//    group: String
//    title: String
//    description: String
//    priority: String ['low', 'med', 'high']
//    done: Boolean
//    }
//    ...
//]
//
//POST /todos { :group (optional), :title (required), :description (optional), :priority (optional), :done (optional) }
//
//{
//    group: String
//    title: String
//    description: String
//    priority: String ['low', 'med', 'high']
//    done: Boolean
//}
//
//PUT DELETE follows standard CRUD

enum Result<T> {
    case error(Error)
    case value(T)
}

//struct TaskToDoService {
//
//    func tasks() -> ToDoTask {
//
//    }
//
//    func createTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
//
//    }
//
//    func updateTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
//
//    }
//
//    func deleteTask(_ task: ToDoTask) -> Observable<Result<Bool>> {
//
//    }
//}
