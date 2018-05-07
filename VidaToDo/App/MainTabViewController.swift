//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaUIKit
import RxCocoa

class MainTabViewController: UITabBarController, Routable {

    static func makeWithURL(_ screenURL: GlobalScreenURL) -> UIViewController? {
        guard case .tab = screenURL else {
            fatalLog("Invalid URL passed to view controller: \(self)")
            return nil
        }
        return MainTabViewController()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabViewControllers: [UIViewController] = []
        
        if let todoListVC = GlobalScreenRouter.shared.viewControllerForURLPath(GlobalScreenURL.toDoList) {
            todoListVC.tabBarItem = UITabBarItem(title: "Todo", image: #imageLiteral(resourceName: "placeholder"), selectedImage: #imageLiteral(resourceName: "placeholderSelected"))
            let navController = UINavigationController(rootViewController: todoListVC)
            tabViewControllers.append(navController)
        }
        
        if let settingsVC = GlobalScreenRouter.shared.viewControllerForURLPath(GlobalScreenURL.settings) {
            settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "placeholder"), selectedImage: #imageLiteral(resourceName: "placeholderSelected"))
            tabViewControllers.append(settingsVC)
        }
        
        viewControllers = tabViewControllers
    }
}
