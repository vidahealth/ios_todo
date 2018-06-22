//
//  NetworkURLObjects.swift
//  Vida
//
//  Created by Brice Pollock on 4/3/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation
import RxSwift

/// AlamoFire has a well defined Result type similar to our definition here, however,
/// Brice thinks its better not to expose AlamoFire everywhere in the app so using our own is preferable.
public enum Result<T> {
    case error(Error)
    case value(T)
}

enum HTTPRequestMethod: String {
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
