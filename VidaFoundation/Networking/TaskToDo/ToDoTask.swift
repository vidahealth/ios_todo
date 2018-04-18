//
//  ToDoTask.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

public struct LocalToDoTask: Codable {
    let group: String?
    let title: String
    let description: String?
}

public struct ToDoTask: Codable {
    public let group: String?
    public let title: String
    public let description: String?
    public let priority: Priority
    public let done: Bool

    public enum Priority: String, Codable {
        case low = "low"
        case medium = "med"
        case high = "high"
    }
}
