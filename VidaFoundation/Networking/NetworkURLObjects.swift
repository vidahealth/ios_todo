//
//  NetworkURLObjects.swift
//  Vida
//
//  Created by Brice Pollock on 4/3/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

enum UrlRequestMethod: String {
    case post   = "POST"
    case get    = "GET"
    case patch  = "PATCH"
    case put    = "PUT"
    case DELETE = "DELETE"
}

enum EndpointVersion: Int {
    case v1 = 1
    case v2
    case v3
    case v4
    case v5
}

enum VidaEndpoint: String {
    case metricpoint = "metricpoint"
}
