//  Created by Axel Ancona Esselmann on 6/21/17.
//  Copyright © 2017 Vida. All rights reserved.
//

import Foundation

extension NSMutableURLRequest {
    convenience init?(endpoint: VidaEndpoint, version: EndpointVersion, type: HTTPRequestMethod, data: Data? = nil) {

        guard let url = URL(endpoint: endpoint, version: version) else {
            return nil
        }

        self.init(url: url)
        httpMethod = type.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let data = data {
            httpBody = data
        }
    }
}
