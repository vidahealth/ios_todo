//
//  VidaEndpoint.swift
//  Vida
//
//  Created by Brice Pollock on 4/3/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

extension URL {
    static let appDomain = "http://www.vida.com"
    init?(endpoint: VidaEndpoint, version: EndpointVersion) {
        let baseURL = "\(URL.appDomain)/api/v\(version.rawValue)/\(endpoint.rawValue)/"
        self.init(string: baseURL)
    }
}
