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

class SettingsPageViewController: UIViewController, Routable {
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

extension SettingsPageViewController: Routable {
    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard case .settings = screenURL else {
            fatalLog("Invalid URL passed to view controller: \(self)")
            return nil
        }
        return SettingsPageViewController()
    }
}
