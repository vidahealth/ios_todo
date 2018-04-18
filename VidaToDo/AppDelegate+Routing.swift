//
//  AppDelegate+Routing.swift
//  VidaToDo
//
//  Created by Alexandre Laurin on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import VidaFoundation

extension AppDelegate {

    func registerModuleURLs() {
        SharedGlobalRouter.registerRendererClass(TodoListTableViewController.self, URLPath: GlobalURL.homeURL.path)
//        SharedGlobalRouter.registerModuleClass(PlainOldFeatureModuleViewController.self, URLPath: ModuleURL.plainOldFeatureModuleURL(featureUUID: "").routingPath)
    }
    
}
