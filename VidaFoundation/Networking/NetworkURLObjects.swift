//
//  NetworkURLObjects.swift
//  Vida
//
//  Created by Brice Pollock on 4/3/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

public enum Result<T> {
    case error(Error)
    case value(T)
}

enum UrlRequestMethod: String {
    case post   = "POST"
    case get    = "GET"
    case patch  = "PATCH"
    case put    = "PUT"
    case delete = "DELETE"
}

enum EndpointVersion: Int {
    case v1 = 1
}

enum VidaEndpoint: String {
    case todos = "todos"
}
