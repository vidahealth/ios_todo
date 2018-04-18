//
//  TodoCardTableViewCell.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import RxSwift
import VidaUIKit

class TodoCardTableViewCell: UITableViewCell {

    let taskTitle = UILabel()
    let dueDate = UILabel()
    let priority = UILabel()

    var bag = DisposeBag()

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }


    /*func configure(with viewDataStream: Observable<TodoCardViewData>) {
        bag = DisposeBag() // Dispose of previous subscriptions since Cell is not de-initialized

        viewDataStream.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (viewData: TodoCardViewData) in
            guard let strongSelf = self else { return }
            strongSelf.configure(with: viewData)
        })
    }*/

    private func setupView() {
        accessoryType = .checkmark

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

    private func clearConfiguration() {
        taskTitle.text = ""
        dueDate.text = ""
        priority.text = ""
    }

    func configure(with viewData: TodoCardViewData) {
        clearConfiguration()

        switch viewData.priority {
        case .high:
            priority.text = "High:"
        case .medium:
            priority.text = "Medium:"
        case .low:
            priority.text = "Low:"
        }

        taskTitle.text = viewData.taskTitle

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: viewData.dueDate)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        dueDate.text = myStringafd
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
