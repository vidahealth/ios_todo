//
//  GlobalStorage.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 5/16/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

class GlobalStorage: Storing {

    struct Keys {
        static let tasks = "tasks"
    }

    private var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        // TODO Alex: Remove bang
        return (url!.appendingPathComponent("Data").path)
    }

    // "//" escapes slash
    //
    func set<T>(_ object: T, forKey key: String) {
        NSKeyedArchiver.archiveRootObject(object, toFile: filePath.appending("\\" + key))
    }

    func object<T: Codable>(forKey key: String) -> T? {

        guard let object = NSKeyedUnarchiver.unarchiveObject(withFile: filePath.appending("\\" + key)) else {
            errorLog("Could not load data for key \(key)")
            return nil
        }

        if let decodedObject = object as? T {
            return decodedObject
        }

        guard let dataObject = object as? Data else {
            fatalLog("Could not obtain data for object at key \(key)")
            return nil
        }

        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: dataObject)
            return decodedObject
        } catch {
            fatalLog("Could not decode data for key \(key)")
            return nil
        }
    }

    func removeObject(forKey key: String) {
        do {
            try FileManager.default.removeItem(at: URL(fileURLWithPath: filePath.appending("\\" + key)))
        } catch {
            errorLog(error)
        }
    }
}
