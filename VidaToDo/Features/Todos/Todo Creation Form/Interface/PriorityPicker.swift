//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaFoundation
import RxCocoa
import RxSwift

/// This looks like it could be general and belong in VidaUIKit, however
/// Since it uses ToDo specific things it belongs in the feature folder.
public class PriorityPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    // Public API
    public var priority: Observable<ToDoTask.Priority> {
        return _priority.asObservable()
    }

    // Private subjects
    private let _priority: Variable<ToDoTask.Priority>
    
    private var priorities: [ToDoTask.Priority] = [.low, .medium, .high]
    
    public init() {
        _priority = Variable<ToDoTask.Priority>(.low)
        
        super.init(frame: CGRect.zero)
        delegate = self
        dataSource = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row].rawValue
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _priority.value = priorities[row]
    }
    
}
