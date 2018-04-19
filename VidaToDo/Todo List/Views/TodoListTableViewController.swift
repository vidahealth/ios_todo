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
import VidaFoundation

class TodoListTableViewController: UIViewController, UITableViewDelegate {

    let viewModel: TodoListTableViewModel
    let todoDataSource = Variable<[ToDoTask]>([])
    let bag = DisposeBag()

    let tableView = UITableView()
    let navbar = UINavigationBar(frame: .zero)

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubscriptions()
    }

    private func setupView() {
        // Setup Navigation Bar
        title = "Todo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))

        // Setup TableView
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.rowHeight = 44;
        tableView.register(TodoCardTableViewCell.self, forCellReuseIdentifier: "todoCard")
        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }

    @objc func addButtonClicked() {
        present(TodoFormViewController(), animated: true, completion: nil)
    }

    private func setupSubscriptions() {

        // Setup data source
        TaskToDoService().tasks()
            .map({ (result: Result<ToDoTaskResponse>) -> [ToDoTask] in
                guard case .value(let tasks) = result else { return [] }

                return tasks.objects
            })
            .subscribe(onNext: { [todoDataSource] (list: [ToDoTask]) in
                todoDataSource.value = list
            })
            .disposed(by: bag)

        /// cellForRow
        todoDataSource
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

        // didDeleteRow
        tableView.rx.itemDeleted
            .subscribe(onNext: { [viewModel, todoDataSource] indexPath in
                todoDataSource.value.remove(at: indexPath.row)
            })
            .disposed(by: bag)
    }
}

extension TodoListTableViewController: TodoListTableViewPresentable {
    var cellPressed: ControlEvent<IndexPath> {
        return tableView.rx.itemSelected
    }
}
