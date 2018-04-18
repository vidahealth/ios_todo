//  Created by Axel Ancona Esselmann on 3/14/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

protocol Storing {
    func object<T>(forKey key: String) -> T?
    func set<T>(_ object: T, forKey key: String)
    func removeObject(forKey key: String)
}

extension Storing {

    func bool(forKey key: String) -> Bool {
        return object(forKey: key) ?? false
    }

    func string(forKey key: String) -> String? {
        return object(forKey: key)
    }

    func double(forKey key: String) -> Double? {
        return object(forKey: key)
    }

    func int(forKey key: String) -> Int? {
        return object(forKey: key)
    }

    func array<T>(forKey key: String) -> [T]? {
        return object(forKey: key)
    }

    func dict<T>(forKey key: String) -> [String: T]? {
        return object(forKey: key)
    }
}
