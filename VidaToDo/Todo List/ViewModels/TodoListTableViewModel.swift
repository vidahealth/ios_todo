//
//  TodoListTableViewModel.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CellSwitchPressedType {
    let index: Int
    let isOn: Bool
}

protocol TodoCardTableViewCellPresentable {
    var cellSwitchPressed: ControlEvent<CellSwitchPressedType> { get }
}

protocol TodoListTableViewPresentable {
    var cellPressed: ControlEvent<IndexPath> { get }
}

class TodoListTableViewModel {
    func bind(todoListTable: TodoListTableViewController) {
        todoListTable.cellPressed.bind { indexPath in
            print("Cell pressed at index: \(indexPath.row)")
        }
    }

    func bind(cell: TodoCardTableViewCell) {
        cell.cellSwitchPressed.bind { cellSwitchEvent in
            print("CellSwitch Pressed at index: \(cellSwitchEvent.index) and isOn: \(cellSwitchEvent.isOn)")
        }
    }
}
