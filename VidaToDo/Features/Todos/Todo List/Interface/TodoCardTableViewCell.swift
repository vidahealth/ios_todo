//
//  TodoCardTableViewCell.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import RxCocoa
import VidaUIKit

struct TodoCardTableViewData {
    let taskID: Int
    let priorityText: String
    let taskTitle: String
    let isDone: Bool
}

class TodoCardTableViewCell: UITableViewCell {

    let switchView = UISwitch(frame: .zero)
    let taskTitle = UILabel()
    let dueDate = UILabel()
    let priority = UILabel()

    private var data: TodoCardTableViewData?
    private let cardIsDoneSubject = PublishSubject<(id: Int, isDone: Bool)>()

    var cardIsDone: Observable<(id: Int, isDone: Bool)> {
        return cardIsDoneSubject
    }

    var bag = DisposeBag()

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSubjects()
    }

    private func setupView() {
        switchView.setOn(false, animated: true)
        accessoryView = switchView

        priority.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        contentView.addSubview(priority)
        priority.layout.align(.left, to: .left, of: contentView, withPadding: 10.0)
        priority.centerVertically()

        taskTitle.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        taskTitle.numberOfLines = 0
        taskTitle.lineBreakMode = .byWordWrapping
        contentView.addSubview(taskTitle)
        taskTitle.layout.align(.left, to: .right, of: priority, withPadding: 5.0)
        taskTitle.centerVertically()

        dueDate.font = UIFont.systemFont(ofSize: 10, weight: .light)
        contentView.addSubview(dueDate)
        dueDate.layout.align(.right, to: .right, of: contentView, withPadding: -10.0)
        dueDate.centerVertically()
    }

    func setupSubjects() {
        switchView.rx.value.subscribe(onNext: { (isOn) in
            guard let id = self.data?.taskID else { return }
            self.cardIsDoneSubject.onNext((id: id, isDone: isOn))
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)
    }

    private func clearConfiguration() {
        taskTitle.text = ""
        dueDate.text = ""
        priority.text = ""
    }

    func configure(with data: TodoCardTableViewData) {
        clearConfiguration()
        self.data = data

        switchView.isOn = data.isDone
        priority.text = data.priorityText
        taskTitle.text = data.taskTitle


//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let myString = formatter.string(from: viewData.dueDate)
//        let yourDate = formatter.date(from: myString)
//        formatter.dateFormat = "dd-MMM-yyyy"
//        let myStringaFD = formatter.string(from: yourDate!)
//        dueDate.text = myStringaFD
    }
}
