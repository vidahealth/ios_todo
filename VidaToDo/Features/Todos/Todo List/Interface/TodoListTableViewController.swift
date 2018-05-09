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

class TodoListTableViewController: UIViewController, UITableViewDelegate, Routable {

    let taskSelectedSubject = PublishSubject<Int>()
    let viewModel: TodoListTableViewModel
    let todoDataSource = Variable<[TodoCardTableViewData]>([])
    let bag = DisposeBag()

    let tableView = UITableView()
    let navbar = UINavigationBar(frame: .zero)

    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard case .toDoList = screenURL else {
            fatalLog("Invalid URL passed to view controller: \(self)")
            return nil
        }
        return TodoListTableViewController(viewModel: TodoListTableViewModel())
    }

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
        viewModel.watchTaskIsSelected(observable: taskSelectedSubject)

        todoDataSource
            .asObservable()
            .bind(to: tableView.rx.items) { [viewModel] (tableView, row, viewData) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoCard") as! TodoCardTableViewCell
                cell.configure(with: viewData)
                cell.tag = row
                viewModel.watchTaskIsDone(observable: cell.cardIsDone)
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
            .subscribe(onNext: { [tableView, viewModel] indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
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
