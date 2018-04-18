//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit
import VidaUIKit
import RxCocoa
import VidaFoundation

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabViewControllers: [UIViewController] = []
        
        if let todoListVC = SharedGlobalRouter.viewControllerForURLPath(GlobalURL.toDoList.routingPath) {
            todoListVC.tabBarItem = UITabBarItem(title: "Todo", image: #imageLiteral(resourceName: "placeholder"), selectedImage: #imageLiteral(resourceName: "placeholderSelected"))
            tabViewControllers.append(todoListVC)
        }
        
        if let settingsVC = SharedGlobalRouter.viewControllerForURLPath(GlobalURL.settings.routingPath) {
            settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "placeholder"), selectedImage: #imageLiteral(resourceName: "placeholderSelected"))
            tabViewControllers.append(settingsVC)
        }
        
        viewControllers = tabViewControllers
    }
}
