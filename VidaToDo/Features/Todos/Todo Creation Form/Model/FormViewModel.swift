//
//  FormViewModel.swift
//  VidaToDo
//
//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

class FormViewModel {

    private let disposeBag = DisposeBag()

    var isValid: Observable<Bool>?
    var hasSubmitted: Observable<Bool>? {
        return _hasSubmitted.asObservable()
    }

    private var _hasSubmitted = Variable<Bool>(false)

    var latestValidData: (String?, Date, ToDoTask.Priority)?

    let manager = TaskToDoManager()

    func bind(title: Observable<String?>, due: Observable<Date>, priority: Observable<ToDoTask.Priority>) {
        let combinedFormValues = Observable<(String?, Date, ToDoTask.Priority)>.combineLatest(title, due, priority, resultSelector: { (title: String?, due: Date, priority: ToDoTask.Priority) -> (String?, Date, ToDoTask.Priority) in
            return (title, due, priority)
        })

        isValid = combinedFormValues.map { [weak self] values in
            let isValid = FormValidator.isValid(title: values.0, due: values.1, priority: values.2)
            if isValid {
                self?.latestValidData = values
                return true
            } else {
                return false
            }
        }
    }

    func submitButtonClicked() {
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
        }).disposed(by: disposeBag)
    }
}
