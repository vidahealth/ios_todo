//
//  NetworkDecoder.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

struct NetworkDecoder {
    static func decodeResult<T: Codable>(_ result: Result<[AnyHashable: Any]>) -> Result<T> {
        switch result {
        case .error(let error):
            return Result.error(error)
        case .value(let json):
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                return Result.value(try JSONDecoder().decode(T.self, from: data))
            } catch {
                print("Unable to decode json: \(error)\n\ndata:\n\(json)")
                return Result.error(error)
            }
        }
    }

    // Decodes a result into a boolean success response
    static func decodeBoolResult(_ result: Result<[AnyHashable: Any]>) -> Result<Bool> {
        switch result {
        case .error(let error):
            return Result.error(error)
        case .value(let json):
            return Result.value(true)
        }
    }
}
