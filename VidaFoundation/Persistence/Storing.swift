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

class GlobalStorage: Storing {

    static let shared = GlobalStorage()

    private init() {}

    private var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Data").path)
    }

    func set<T>(_ object: T, forKey key: String) {
        NSKeyedArchiver.archiveRootObject(object, toFile: filePath.appending("\\" + key))
    }

    func object<T>(forKey key: String) -> T? {
        guard let object = NSKeyedUnarchiver.unarchiveObject(withFile: filePath.appending("\\" + key)) as? T else {
            errorLog("Could not load data for key \(key)")
            return nil
        }
        return object
    }

    func removeObject(forKey key: String) {
        do {
            try FileManager.default.removeItem(at: URL(fileURLWithPath: filePath.appending("\\" + key)))
        } catch {
            errorLog(error)
        }
    }
}
