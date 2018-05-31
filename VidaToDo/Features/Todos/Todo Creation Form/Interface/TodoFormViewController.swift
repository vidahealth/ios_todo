//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaUIKit


class TodoFormViewController: UIViewController {
    // UI
    private let closeButton = UIButton()
    private let addButton = UIButton()
    private let formFields = FormFields()

    // private
    private let viewModel = FormViewModel()
    private let bag = DisposeBag()

    // MARK: Config
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(formFields)
        formFields.left(10).top(100).right(10)

        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        view.addSubview(closeButton)

        closeButton.right().top(12)

        addButton.setTitle("Add", for: .normal)
        view.addSubview(addButton)

        addButton.right().left().bottom()

        subscribeTheViewModel(viewModel)
        subscribeToViewModel(viewModel)
    }

    func subscribeTheViewModel(_ viewModel: FormViewModel) {
        viewModel.subscribeToFormUpdateObservables(title: formFields.title, due: formFields.due, priority: formFields.priority)
        viewModel.subscribeToSubmitRequestedObservable(addButton.rx.tap.asObservable())
        viewModel.subscribeToDismissRequestedObservable(closeButton.rx.tap.asObservable())
    }

    func subscribeToViewModel(_ viewModel: FormViewModel) {
        viewModel.isValid.subscribe(onNext: { [weak self] isValid in
            self?.setButton(isEnabled: isValid)
        }).disposed(by: bag)

        viewModel.dismiss.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)
    }

    // MARK: private

    func setButton(isEnabled: Bool) {
        if isEnabled {
            addButton.isEnabled = true
            addButton.setTitleColor(.black, for: .normal)
        } else {
            addButton.isEnabled = false
            addButton.setTitleColor(.gray, for: .normal)
        }
    }
}

extension TodoFormViewController: Routable {
    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard case .todoForm = screenURL else {
            fatalLog("Invalid URL passed to view controller: \(self)")
            return nil
        }
        return TodoFormViewController()
    }
}
