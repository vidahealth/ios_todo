//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaUIKit
import VidaFoundation
import RxCocoa
import RxSwift

class FormFields: UIStackView {
    
    struct Const {
        static let title = "Title"
        static let due = "Due"
        static let priority = "Priority"
    }
    
    private let titleLabel = UILabel()
    private let dueLabel = UILabel()
    private let priorityLabel = UILabel()
    
    private let titleTextField = TodoTextField()
    private let duePicker = UIDatePicker()
    private let priorityPicker = PriorityPicker()
    
    public var priority: Observable<ToDoTask.Priority> {
        return priorityPicker.priority
    }
    
    public var due: Observable<Date> {
        return duePicker.rx.value.asObservable()
    }
    
    public var title: Observable<String?> {
        return titleTextField.rx.value.asObservable()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .blue
        
        titleLabel.text = Const.title
        dueLabel.text = Const.due
        priorityLabel.text = Const.priority
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(titleTextField)
        addArrangedSubview(dueLabel)
        addArrangedSubview(duePicker)
        addArrangedSubview(priorityLabel)
        addArrangedSubview(priorityPicker)
        alignment = .fill
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
