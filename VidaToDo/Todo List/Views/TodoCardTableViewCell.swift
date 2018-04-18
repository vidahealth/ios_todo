//
//  TodoCardTableViewCell.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import RxSwift
import RxCocoa
import VidaUIKit
import VidaFoundation

class TodoCardTableViewCell: UITableViewCell {

    let switchView = UISwitch(frame: .zero)
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

    private func clearConfiguration() {
        taskTitle.text = ""
        dueDate.text = ""
        priority.text = ""
    }

    func configure(with viewData: ToDoTask) {
        clearConfiguration()

        switchView.isOn = viewData.done

        switch viewData.priority {
        case .high:
            priority.text = "High:"
        case .medium:
            priority.text = "Medium:"
        case .low:
            priority.text = "Low:"
        }

        taskTitle.text = viewData.title

//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let myString = formatter.string(from: viewData.dueDate)
//        let yourDate = formatter.date(from: myString)
//        formatter.dateFormat = "dd-MMM-yyyy"
//        let myStringaFD = formatter.string(from: yourDate!)
//        dueDate.text = myStringaFD
    }

    var switchPressedStream = PublishSubject<CellSwitchPressedType>()
}

extension TodoCardTableViewCell: TodoCardTableViewCellPresentable {
    
    var cellSwitchPressed: ControlEvent<CellSwitchPressedType> {
        let source = switchView.rx.value
            .map { [weak self] (isOn: Bool) -> CellSwitchPressedType in
            return CellSwitchPressedType(index: self?.tag ?? -1, isOn: isOn)
        }
            .filter { (cellSwitch: CellSwitchPressedType) -> Bool in
                cellSwitch.index != -1
        }
            .skip(1)
        
        return ControlEvent(events: source)
    }


}
