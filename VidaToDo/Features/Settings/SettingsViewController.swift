//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaFoundation
import RxSwift

class SettingsViewController: UIPageViewController {
    let viewModel = SettingsViewModel()
    var pageViewControllers = [SettingsPageViewController]()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        view.backgroundColor = .white

        bag.insert(viewModel.pages.subscribe(onNext: { (pageData) in
            self.pageViewControllers = pageData.map {
                let viewController: SettingsPageViewController = SettingsPageViewController.createInstanceFromStoryboard()
                viewController.configure(data: $0)
                return viewController
            }

            guard let first = self.pageViewControllers.first else {
                return
            }
            self.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }, onError: nil, onCompleted: nil, onDisposed: nil))
    }
}

extension SettingsViewController: UIPageViewControllerDelegate {

}

extension SettingsViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let settingsPage = viewController as? SettingsPageViewController, let currentIndex = pageViewControllers.index(of: settingsPage) else {
            return nil
        }
        return pageViewControllers[safe: currentIndex + 1]
        
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let settingsPage = viewController as? SettingsPageViewController, let currentIndex = pageViewControllers.index(of: settingsPage) else {
            return nil
        }
        return pageViewControllers[safe: currentIndex - 1]
    }
}
