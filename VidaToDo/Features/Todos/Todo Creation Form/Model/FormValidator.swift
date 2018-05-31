//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

class FormValidator {
    static func validateFormData(_ formData: ToDoFormSheetData?) -> ValidToDoFormData? {
        guard let form = formData, let title = form.title, title.count > 0 else {
            return nil
        }
        return ValidToDoFormData(title: title, due: form.due, priority: form.priority)
    }
}

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    return formatter.string(from: date)
}
