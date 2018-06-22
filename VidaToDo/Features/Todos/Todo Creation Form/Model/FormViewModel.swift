//
//  FormViewModel.swift
//  VidaToDo
//
//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

struct ValidToDoFormData {
    let title: String
    let due: Date
    let priority: ToDoTask.Priority
}

struct ToDoFormSheetData {
    let title: String?
    let due: Date
    let priority: ToDoTask.Priority
}

// TODO: Do we like this file structure?
class FormViewModel {

    // Subjects / Observables
    private let formDataSubject = BehaviorSubject<ToDoFormSheetData?>(value: nil)
    private var validDataSubject: Observable<ValidToDoFormData?> {
        return formDataSubject.map { (currentForm) in
            return FormValidator.validateFormData(currentForm)
        }
    }
    public var isValid: Observable<Bool> {
        return validDataSubject.map({ (data) -> Bool in
            return data != nil
        })
    }

    private let hasSubmittedSubject = BehaviorSubject<Bool>(value: false)
    public var hasSubmitted: Observable<Bool> {
        return hasSubmittedSubject
    }

    private let dismissSubject = PublishSubject<Void>()
    public var dismiss: Observable<Void> {
        return dismissSubject
    }

    // Private
    private let bag = DisposeBag()
    private let manager = TaskToDoManager()

    // MARK: Public subscriptions
    func subscribeToFormUpdateObservables(title: Observable<String?>, due: Observable<Date>, priority: Observable<ToDoTask.Priority>) {
        let combinedFormValues = Observable.combineLatest(title, due, priority, resultSelector: { (title: String?, due: Date, priority: ToDoTask.Priority) in
            return ToDoFormSheetData(title: title, due: due, priority: priority)
        })

        combinedFormValues.subscribe(onNext: { [weak self] (data) in
            self?.formDataSubject.onNext(data)
        }).disposed(by: bag)
    }

    func subscribeToDismissRequestedObservable(_ observable: Observable<Void>) {
        observable.subscribe(onNext: { [weak self] in
            self?.dismissSubject.onNext(())
        }).disposed(by: bag)
    }

    func subscribeToSubmitRequestedObservable(_ observable: Observable<Void>) {
        observable.withLatestFrom(validDataSubject).subscribe(onNext: { [weak self] (form) in
            guard let strongSelf = self else { return }
            guard let form = form else { return }

            let todoItem = LocalToDoTask(group: nil, title: form.title, description: nil, priority: form.priority, done: false)
            strongSelf.manager.createTask(todoItem).subscribe(onNext: { [weak self] (result) in
                guard case .value(_) = result else {
                    errorLog("failed creation")
                    return
                }
                self?.dismissSubject.onNext(())
                return
            }).disposed(by: strongSelf.bag)
        }).disposed(by: bag)
    }
}
