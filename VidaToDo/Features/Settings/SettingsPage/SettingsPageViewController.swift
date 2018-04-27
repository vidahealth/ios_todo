//
//  SettingsPageViewController.swift
//  VidaToDo
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit

struct SettingsPageViewData {
    let text: String
}

// BRICE: Do I have to give up this model of storyboard?
class SettingsPageViewController: UIViewController {
    @IBOutlet weak var mainTextView: UITextView!

    var viewData: SettingsPageViewData?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let data = viewData else {
            return
        }
        configure(data: data)
    }

    func configure(data: SettingsPageViewData) {
        self.viewData = data
        guard isViewLoaded else { return }
        mainTextView.text = data.text
    }
}
