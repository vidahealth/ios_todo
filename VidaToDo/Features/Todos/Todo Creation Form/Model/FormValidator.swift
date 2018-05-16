//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

class FormValidator {
    static func makeFormSheet(title: String?, due: Date, priority: ToDoTask.Priority) -> ToDoFormSheetData? {
        guard let title = title, title.count > 0 else {
            return nil
        }
        return ToDoFormSheetData(title: title, due: due, priortiy: priority)
    }
}

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    return formatter.string(from: date)
}
