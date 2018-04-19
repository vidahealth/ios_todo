//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import VidaFoundation

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
