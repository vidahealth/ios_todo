//
//  TodoListTableViewModel.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import RxCocoa


// TODO: Strings should be in a strings constant section
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

    // TODO: Define a pattern for using distinctUntilChanged to only update the UI if view data has changed.
    var tasks: Observable<[TodoCardTableViewData]> {
        // TODO: Define a suite of patterns for cacheOnly (take(1)?), networkOnly (skip(1)?) type things
        return taskToDoManager.tasks().map({ (tasks) -> [TodoCardTableViewData] in
            return tasks.map {
                return TodoCardTableViewData(taskID: $0.id, priorityText: $0.priority.text(), taskTitle: $0.title, isDone: $0.done)
            }
        })
    }

    // BRICE: Do we want this or bind?

    // Potentially change in naming:
    // TODO: func subscribeToTaskIsDoneObservable(_ observable:....)
    func watchTaskIsDone(observable: Observable<(id: Int, isDone: Bool)>) {
        observable.withLatestFrom(taskToDoManager.tasks()) { (taskIsDoneTuple, tasks) -> (ToDoTask?, Bool) in
                let (taskID, isDone) = taskIsDoneTuple
                return (tasks.filter({$0.id == taskID}).first, isDone)
            }.flatMap({ (task, isDone) -> Observable<Result<Bool>> in
                guard let task = task else {
                    // TODO: Should not be network errroe here, would require knowing impl. of manager
                    let error = NetworkError(type: .invalidUrl, message: "unable to find task that is done for task")
                    errorLog(error)
                    return Observable.just(Result.error(error))
                }
                // TODO: Investigate if we want network request to return Singles
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
    // TODO: Update UI based on task selection
    // TODO: Rename
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

    func removeTask(at index: Int) {
        
    }
}
