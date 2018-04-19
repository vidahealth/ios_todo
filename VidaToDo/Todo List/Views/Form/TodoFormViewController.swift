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

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    return formatter.string(from: date)
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

        viewModel.bind(title: formFields.title, due: formFields.due, priority: formFields.priority)

        viewModel.isValid?.subscribe(onNext: { [weak self] isValid in
            self?.setButton(isEnabled: isValid)
        }).disposed(by: disposeBag)

        viewModel.hasSubmitted?.subscribe(onNext: { [weak self] isValid in
            self?.dismiss()
        }).disposed(by: disposeBag)

        closeButton.setTitle("X", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        closeButton.setTitleColor(.black, for: .normal)
        view.addSubview(closeButton)

        closeButton.right().top(12)

        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        view.addSubview(addButton)

        addButton.right().left().bottom()
    }

    @objc func closeButtonClicked() {
        dismiss()
    }

    @objc func addButtonClicked() {
        viewModel.submitButtonClicked()
    }

    func setButton(isEnabled: Bool) {
        if isEnabled {
            addButton.isEnabled = true
            addButton.setTitleColor(.black, for: .normal)
        } else {
            addButton.isEnabled = false
            addButton.setTitleColor(.gray, for: .normal)
        }
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

}
