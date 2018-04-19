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

class FormViewModel {

    private let disposeBag = DisposeBag()

    var isValid: Observable<Bool>?

    var latestValidData: (String?, Date, ToDoTask.Priority)?

    init() { }

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
}

class TodoFormViewController: UIViewController {
    
    private let formFields = FormFields()

    let viewModel = FormViewModel()

    var closeButton = UIButton()
    var addButton = UIButton()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(formFields)
        formFields.left(10).top(100).right(10)
        view.backgroundColor = .blue

        viewModel.bind(title: formFields.title, due: formFields.due, priority: formFields.priority)

        viewModel.isValid?.subscribe(onNext: { isValid in
            print(isValid)
        }).disposed(by: disposeBag)

        closeButton.setTitle("X", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        view.addSubview(closeButton)

        closeButton.right().top(12)

        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.right().left().bottom()


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

    }

    @objc func closeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

    @objc func addButtonClicked() {

    }
    

}

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    return formatter.string(from: date)
}
