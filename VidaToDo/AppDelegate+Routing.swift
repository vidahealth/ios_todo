//
//  AppDelegate+Routing.swift
//  VidaToDo
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import VidaFoundation

// register all renderers here

extension AppDelegate {

    func registerModuleURLs() {
        SharedGlobalRouter.registerViewControllerClass(MainTabViewController.self, URLPath: GlobalURL.tab.routingPath)
        SharedGlobalRouter.registerViewControllerClass(TodoListTableViewController.self, URLPath: GlobalURL.toDoList.routingPath)
        SharedGlobalRouter.registerViewControllerClass(SettingsViewController.self, URLPath: GlobalURL.settings.routingPath)
//        SharedGlobalRouter.registerModuleClass(newFeatureViewController.self, URLPath: GlobalURL.newFeature.routingPath)
    }
    
}
