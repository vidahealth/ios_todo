//
//  TodoCardTableViewCell.swift
//  VidaToDo
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import RxSwift

class TodoCardTableViewCell: UITableViewCell {

    let title = UILabel()
    let dueDate = UILabel()

    var bag = DisposeBag()

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }


    func configure(with viewDataStream: Observable<TodoCardViewData>) {
        bag = DisposeBag() // Dispose of previous subscriptions since Cell is not de-initialized

        viewDataStream.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (viewData: TodoCardViewData) in
            guard let strongSelf = self else { return }
            strongSelf.configure(with: viewData)
        })
    }

    private func setupView() {
        title.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        title.numberOfLines = 0
        title.text = "Do something"
        title.lineBreakMode = .byWordWrapping
        contentView.addSubview(title)
        title.layout.align(.left, to: .left, of: contentView, withPadding: 5.0)
        title.centerVertically()

        dueDate.font = UIFont.systemFont(ofSize: 10, weight: .light)
        dueDate.text = "April 18, 2018"
        contentView.addSubview(dueDate)
        dueDate.layout.align(.right, to: .right, of: contentView, withPadding: 5.0)
        dueDate.centerVertically()
    }

    private func configure(with viewData: TodoCardViewData) {

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
