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

class TodoListTableViewController: UIViewController, UITableViewDelegate {

    let taskSelectedSubject = PublishSubject<Int>()
    let viewModel: TodoListTableViewModel
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

        //viewModel.bind(todoListTable: self)
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
        
        viewModel.tasks
            .bind(to: tableView.rx.items) { [viewModel] (tableView, row, viewData) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "todoCard") as! TodoCardTableViewCell
                cell.configure(with: viewData)
                cell.tag = row
                viewModel.watchTaskIsDone(observable: cell.cardIsDone)
                return cell
            }
            .disposed(by: bag)

        // didSelectRow
        tableView.rx.itemSelected
            .subscribe(onNext: { [tableView] indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
                //FIXME: need to get taskID and send to view model
                //taskSelectedSubject.onNext(taskID)
            })
            .disposed(by: bag)
    }
}

