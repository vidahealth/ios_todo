//
//  TodoListTableViewController.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import VidaUIKit

class TodoListTableViewController: UIViewController, UITableViewDelegate {

    let bag = DisposeBag()
    let tableView = UITableView()

    let sampleViewData: Variable<[TodoCardViewData]> = Variable([
        TodoCardViewData(taskTitle: "Task 1", dueDate: Date(year: 2018, month: 04, day: 1)!, priority: .low),
        TodoCardViewData(taskTitle: "Task 2", dueDate: Date(year: 2018, month: 04, day: 2)!, priority: .high),
        TodoCardViewData(taskTitle: "Task 3", dueDate: Date(year: 2018, month: 04, day: 3)!, priority: .medium),
        TodoCardViewData(taskTitle: "Task 4", dueDate: Date(year: 2018, month: 04, day: 4)!, priority: .medium),
        TodoCardViewData(taskTitle: "Task 5", dueDate: Date(year: 2018, month: 04, day: 5)!, priority: .high),
        TodoCardViewData(taskTitle: "Task 6", dueDate: Date(year: 2018, month: 04, day: 6)!, priority: .low)
    ])

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(TodoCardTableViewCell.self, forCellReuseIdentifier: "todoCard")

        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)

        sampleViewData
            .value
            .sort(by: { (lhs: TodoCardViewData, rhs: TodoCardViewData) -> Bool in
                return lhs.priority.rawValue > rhs.priority.rawValue
            })

        sampleViewData
            .asObservable()
            .bind(to: tableView.rx.items) { (tableView, row, viewData) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoCard") as! TodoCardTableViewCell
                cell.configure(with: viewData)

                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.tag = row // for detect which row switch Changed
                //switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                cell.accessoryView = switchView

                return cell
        }
        .disposed(by: bag)

        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                //
            })
        .disposed(by: bag)

    }
}

