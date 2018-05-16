//
//  FormViewModel.swift
//  VidaToDo
//
//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

struct ToDoFormSheetData {
    let title: String
    let due: Date
    let priortiy: ToDoTask.Priority
}

// TODO: Do we like this file structure?
class FormViewModel {

    // Public API
    public var isValid: Observable<Bool> {
        return _validData.asObservable().map({ (data) -> Bool in
            return data != nil
        })
    }
    public var hasSubmitted: Observable<Bool> {
        return _hasSubmitted.asObservable()
    }

    // Subjects
    public var _validData = Variable<ToDoFormSheetData?>(nil)
    private var _hasSubmitted = Variable<Bool>(false)

    // Private
    private let bag = DisposeBag()
    private var latestValidData: (String?, Date, ToDoTask.Priority)?
    private let manager = TaskToDoManager()

    func subscribeToFormUpdateObservables(title: Observable<String?>, due: Observable<Date>, priority: Observable<ToDoTask.Priority>) {
        let combinedFormValues = Observable<(String?, Date, ToDoTask.Priority)>.combineLatest(title, due, priority, resultSelector: { (title: String?, due: Date, priority: ToDoTask.Priority) -> (String?, Date, ToDoTask.Priority) in
            return (title, due, priority)
        })

        combinedFormValues.subscribe(onNext: { [weak self] (values) in
            self?._validData.value = FormValidator.makeFormSheet(title: values.0, due: values.1, priority: values.2)
        }).disposed(by: bag)
    }

    func submitButtonSelected() {
        guard let title = latestValidData?.0, let _ = latestValidData?.1, let priority = latestValidData?.2 else {
            return
        }
        let todoItem = LocalToDoTask(group: nil, title: title, description: nil, priority: priority, done: false)
        manager.createTask(todoItem).subscribe(onNext:  { (result) in
            guard case .value(_) = result else {
                errorLog("failed creation")
                return
            }
            self._hasSubmitted.value = true
            return
        }).disposed(by: bag)
    }
}
