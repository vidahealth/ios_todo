//
//  AppDelegate+Routing.swift
//  VidaToDo
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

// register all renderers here

import VidaUIKit

extension AppDelegate {

    func registerModuleURLs() {
        GlobalScreenRouter.shared.registerViewControllerClass(MainTabViewController.self, screenURL: GlobalScreenURL.tab)
        GlobalScreenRouter.shared.registerViewControllerClass(TodoListTableViewController.self, screenURL: GlobalScreenURL.toDoList)
        GlobalScreenRouter.shared.registerViewControllerClass(SettingsPageViewController.self, screenURL: GlobalScreenURL.settings)
        GlobalScreenRouter.shared.registerViewControllerClass(TodoFormViewController.self, screenURL: GlobalScreenURL.todoForm)
//        GlobalScreenRouter.shared.registerModuleClass(newFeatureViewController.self, screenURL: GlobalScreenURL.newFeature)
    }
    
}
