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
        SharedGlobalRouter.registerRendererClass(TodoListTableViewController.self, URLPath: GlobalURL.homeURL.routingPath)
//        SharedGlobalRouter.registerModuleClass(newFeatureViewController.self, URLPath: GlobalURL.newFeature.routingPath)
    }
    
}
