//
//  ModuleURL.swift
//
//  Created by Brice Pollock on 6/12/15.
//  Copyright (c) 2015 Brice Pollock. All rights reserved.
//

import Foundation

// When creating a new renderer, you have to create a case for it in the GlobalURL, and give it a string URL in the GLobalURL path.

public enum GlobalURL: CustomStringConvertible {
    case tab
    case toDoList
    case settings
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

public protocol Path {
    var path : String { get }
}

extension GlobalURL: Path {
    public var path: String {
        switch self {
        case .tab: return "/tab"
        case .toDoList: return "/toDoList"
        case .settings: return "/settings"
//        case .newFeature: return "/newFeature"
        }
    }
}

// MARK: Routing

extension GlobalURL {
    public var routingPath: String {
        return path
    }
}
