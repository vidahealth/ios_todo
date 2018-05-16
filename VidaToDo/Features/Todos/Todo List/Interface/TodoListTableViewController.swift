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

    private let taskSelectedSubject = PublishSubject<Int>()
    private let viewModel: TodoListTableViewModel
    private let todoDataSource = Variable<[TodoCardTableViewData]>([])
    private let bag = DisposeBag()

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
        setupSubscriptions()
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

    private func setupSubscriptions() {
        viewModel.subscribeToTaskIsSelectedObservable(taskSelectedSubject)

        todoDataSource
            .asObservable()
            .bind(to: tableView.rx.items) { [viewModel] (tableView, row, viewData) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoCard") as! TodoCardTableViewCell
                cell.configure(with: viewData)
                cell.tag = row
                viewModel.subscribeToTaskIsDoneObservable(cell.cardIsDone)
                return cell
            }
            .disposed(by: bag)
        
        viewModel.tasks
            .subscribe(onNext: { [todoDataSource] (viewData: [TodoCardTableViewData]) in
                todoDataSource.value += viewData
            })
            .disposed(by: bag)

        // didSelectRow
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak tableView] indexPath in
                tableView?.deselectRow(at: indexPath, animated: true)
                //FIXME: need to get taskID and send to view model
                // viewModel.selectedRow(at: indexPath.row)
            })
            .disposed(by: bag)

        // didDeleteRow
        tableView.rx.itemDeleted
            .subscribe(onNext: { [viewModel] indexPath in
                viewModel.removeTask(at: indexPath.row)
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
