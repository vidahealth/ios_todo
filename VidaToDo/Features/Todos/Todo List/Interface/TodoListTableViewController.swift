//
//  TodoListTableViewController.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import RxCocoa
import VidaUIKit

class TodoListTableViewController: UIViewController {

    private let viewModel: TodoListTableViewModel
    private let bag = DisposeBag()

    private let taskSelectedSubject = PublishSubject<Int>()

    private let tableView = UITableView()
    let navbar = UINavigationBar(frame: .zero)

    fileprivate init(viewModel: TodoListTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        subscribeTheViewModel(viewModel)
        subscribeToViewModel(viewModel)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }

    private func setupView() {
        setupNavBar()

        // Setup TableView
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.rowHeight = 44;

        tableView.register(TodoCardTableViewCell.self, forCellReuseIdentifier: "todoCard")

        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
    }

    private func setupNavBar() {
        title = "Todo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    }

    @objc func addButtonClicked() {
        present(TodoFormViewController(), animated: true, completion: nil)
    }

    private func subscribeTheViewModel(_ viewModel: TodoListTableViewModel) {
        // empty
    }

    private func subscribeToViewModel(_ viewModel: TodoListTableViewModel) {
        viewModel.tasksViewData
            .bind(to: tableView.rx.items) { [viewModel] (tableView, row, viewData) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoCard") as! TodoCardTableViewCell
                cell.configure(with: viewData)
                cell.tag = row
                viewModel.subscribeToTaskIsDoneObservable(cell.cardIsDone)
                return cell
            }
            .disposed(by: bag)

        // didSelectRow
        Observable.combineLatest(tableView.rx.itemSelected.asObservable(), viewModel.tasksViewData)
            .subscribe(onNext: { [weak tableView, weak self] (indexPath, tasks) in
                tableView?.deselectRow(at: indexPath, animated: true)

                guard let taskID = tasks[safe: indexPath.row]?.taskID else { return }
                self?.viewModel.taskIsSelected(taskID: taskID)
            })
            .disposed(by: bag)

        // didDeleteRow
        Observable.combineLatest(tableView.rx.itemDeleted.asObservable(), viewModel.tasksViewData)
            .subscribe(onNext: { [weak self] (indexPath, tasks) in
                guard let taskID = tasks[safe: indexPath.row]?.taskID else { return }
                self?.viewModel.removeTaskWithID(taskID)
            })
            .disposed(by: bag)
    }
}

extension TodoListTableViewController: Routable {
    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard case .toDoList = screenURL else {
            fatalLog("Invalid URL passed to view controller: \(self)")
            return nil
        }
        return TodoListTableViewController(viewModel: TodoListTableViewModel())
    }
}

/// Empty because we use the Rx methods
extension TodoListTableViewController: UITableViewDelegate { }
