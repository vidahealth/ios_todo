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
    let viewModel: TodoListTableViewModel

    convenience init() {
        let viewModel = TodoListTableViewModel()
        self.init(viewModel: viewModel)
    }

    init(viewModel: TodoListTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.bind(todoListTable: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let sampleViewData: Variable<[TodoCardViewData]> = Variable([
        TodoCardViewData(taskTitle: "Task 1", dueDate: Date(year: 2018, month: 04, day: 1)!, priority: .low, isComplete: true),
        TodoCardViewData(taskTitle: "Task 2", dueDate: Date(year: 2018, month: 04, day: 2)!, priority: .high, isComplete: false),
        TodoCardViewData(taskTitle: "Task 3", dueDate: Date(year: 2018, month: 04, day: 3)!, priority: .medium, isComplete: true),
        TodoCardViewData(taskTitle: "Task 4", dueDate: Date(year: 2018, month: 04, day: 4)!, priority: .medium, isComplete: false),
        TodoCardViewData(taskTitle: "Task 5", dueDate: Date(year: 2018, month: 04, day: 5)!, priority: .high, isComplete: false),
        TodoCardViewData(taskTitle: "Task 6", dueDate: Date(year: 2018, month: 04, day: 6)!, priority: .low, isComplete: true),
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubscriptions()
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(TodoCardTableViewCell.self, forCellReuseIdentifier: "todoCard")

        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }

    private func setupSubscriptions() {
        // cellForRow
        sampleViewData
            .asObservable()
            .bind(to: tableView.rx.items) { [viewModel] (tableView, row, viewData) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoCard") as! TodoCardTableViewCell
                cell.configure(with: viewData)
                cell.tag = row
                viewModel.bind(cell: cell)

                return cell
            }
            .disposed(by: bag)

        // didSelectRow
        tableView.rx.itemSelected
            .subscribe(onNext: { [tableView] indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: bag)
    }
}

extension TodoListTableViewController: TodoListTableViewPresentable {
    var cellPressed: ControlEvent<IndexPath> {
        return tableView.rx.itemSelected
    }
}

