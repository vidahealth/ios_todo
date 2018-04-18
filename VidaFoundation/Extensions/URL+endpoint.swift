//
//  VidaEndpoint.swift
//  Vida
//
//  Created by Brice Pollock on 4/3/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

extension URL {
    init?(endpoint: VidaEndpoint, version: EndpointVersion) {
        // For this unique sample App we won't need the endpoint version for our sample endpoint
        let baseURL = "\(NetworkManager.scheme)://\(NetworkManager.host)/\(endpoint.rawValue)"
        self.init(string: baseURL)
    }
}
