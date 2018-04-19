//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaUIKit
import VidaFoundation
import RxCocoa
import RxSwift

class FormValidator {
    static func isValid(title: String?, due: Date, priority: ToDoTask.Priority) -> Bool {
        guard
            let title = title, title.count > 0,
            due > Date()
        else {
            return false
        }
        return true
    }
}

class FromViewModel {
    
}

class TodoFormViewController: UIViewController {
    
    private let formFields = FormFields()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(formFields)
        formFields.left().top(100).right()
        
//        formFields.priority.subscribe(onNext: { element in
//            print(element)
//        }).disposed(by: disposeBag)
//
//        formFields.due.subscribe(onNext: { element in
//            print(element)
//        }).disposed(by: disposeBag)
//
//        formFields.title.subscribe(onNext: { element in
//            print(element)
//        }).disposed(by: disposeBag)
        
        let combinedFormValues = Observable<(String?, Date, ToDoTask.Priority)>.combineLatest(formFields.title, formFields.due, formFields.priority, resultSelector: { (title: String?, due: Date, priority: ToDoTask.Priority) -> (String?, Date, ToDoTask.Priority) in
            return (title, due, priority)
        })

        
        let isValid: Observable<Bool> = combinedFormValues.map { FormValidator.isValid(title: $0.0, due: $0.1, priority: $0.2) }
        
        isValid.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)

        
    }
    

}

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    return formatter.string(from: date)
}
