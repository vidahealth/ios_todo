//
//  ToDoTask.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

public struct LocalToDoTask: Codable {
    let group: String
    let title: String
    let description: String
}

public struct ToDoTask: Codable {
    let group: String?
    let title: String
    let description: String?
    let priority: Priority
    let done: Bool

    enum Priority: String, Codable {
        case low = "low"
        case medium = "med"
        case high = "high"
    }
}
