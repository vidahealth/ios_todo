//
//  SettingsPageViewController.swift
//  VidaToDo
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import UIKit
import VidaFoundation

struct SettingsPageViewData {
    let text: String
}

class SettingsPageViewController: UIViewController {
    @IBOutlet weak var mainTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(data: SettingsPageViewData) {
        mainTextView.text = data.text
    }
}
