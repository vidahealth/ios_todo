//
//  TodoCardViewData.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import RxSwift

enum Priority: Int {
    case low = 0
    case medium
    case high
}

struct TodoCardViewData {
    let taskTitle: String
    let dueDate: Date
    let priority: Priority
}

class TodoCardViewDataFactory {
    // Use this function to assemble your list of TodoCardViewData
    func createViewDataUsing() -> [TodoCardViewData] {
        return []
    }
}
