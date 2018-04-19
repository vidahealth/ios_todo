//
//  TodoListTableViewModel.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import VidaFoundation

extension ToDoTask.Priority {
    func text() -> String {
        switch self {
        case .high:
            return "High:"
        case .medium:
            return "Medium:"
        case .low:
            return "Low:"
        }
    }
}

class TodoListTableViewModel {
    let taskToDoManager = TaskToDoManager()
    let bag = DisposeBag()

    var tasks: Observable<[TodoCardTableViewData]> {
        return taskToDoManager.tasks().map({ (tasks) -> [TodoCardTableViewData] in
            return tasks.map {
                return TodoCardTableViewData(taskID: $0.id, priorityText: $0.priority.text(), taskTitle: $0.title, isDone: $0.done)
            }
        })
    }

    func watchTaskIsDone(observable: Observable<(id: Int, isDone: Bool)>) {
        observable.withLatestFrom(taskToDoManager.tasks()) { (taskIsDoneTuple, tasks) -> (ToDoTask?, Bool) in
                let (taskID, isDone) = taskIsDoneTuple
                return (tasks.filter({$0.id == taskID}).first, isDone)
            }.flatMap({ (task, isDone) -> Observable<Result<Bool>> in
                guard let task = task else {
                    let error = NetworkError(type: .invalidUrl, message: "unable to find task that is done for task")
                    errorLog(error)
                    return Observable.just(Result.error(error))
                }
                return self.taskToDoManager.updateTask(ToDoTask(id: task.id, group: task.group, title: task.title, description: task.description, priority: task.priority, done: isDone))
            }).subscribe(onNext: { (result) in
                guard case .value(_) = result else {
                    errorLog("unable to update task for isDone")
                    // FIXME: We always fail sending to the server
                    return
                }
                return
            }).disposed(by: bag)
    }

    func watchTaskIsSelected(observable: Observable<Int>) {
        observable.withLatestFrom(taskToDoManager.tasks()) { (taskID, tasks) -> ToDoTask? in
            return tasks.filter({$0.id == taskID}).first
            }.subscribe(onNext: { (task: ToDoTask?) in
                guard let _ = task else {
                    errorLog("unable to find task")
                    return
                }
                // TODO: Do something with the task selection
                return
            }).disposed(by: bag)

    }
}
