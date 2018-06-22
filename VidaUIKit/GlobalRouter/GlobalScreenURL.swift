//
//  ModuleURL.swift
//
//  Created by Brice Pollock on 6/12/15.
//  Copyright (c) 2015 Brice Pollock. All rights reserved.
//

import Foundation

// When creating a new renderer, you have to create a case for it in the GlobalURL, and give it a string URL in the GLobalURL path.
public enum GlobalScreenURL: CustomStringConvertible {
    case tab
    case toDoList
    case settings
    case todoForm
//    case newFeature

    public func moduleURL() -> URL? {
        let URL = Foundation.URL(string: "pack-list-mobile://app")!
        return URL.appendingPathComponent(path)
    }

    public var description: String {
        return moduleURL()?.description ?? ""
    }
}

// MARK: Define URLs

// This is a parameter dependant path passed to view controller to initialize themselves
// Ex: .../lessons/<the_provided_lesson_uri>
extension GlobalScreenURL {
    public var path: String {
        switch self {
        case .tab: return "tab"
        case .toDoList: return "toDoList"
        case .settings: return "settings"
        case .todoForm: return "todoForm"
//        case .newFeature: return "newFeature"
        }
    }
}

// MARK: Routing

// This is a parameter independent path used to find and register view controllers
// Ex: .../lessons/:lessonURI
extension GlobalScreenURL {
    public var routingPath: String {
        return path
    }
}
