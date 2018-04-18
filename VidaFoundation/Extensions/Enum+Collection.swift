//
//  Enum+Collection.swift
//  Vida
//
//  Created by Brice Pollock on 3/28/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

/// Adhere to this protocol on an enum to get an 'all' function for free to list all enums
/// Ex: enum SomeEnum: EnumCollection { ... } call by: SomeEnum.all()
protocol EnumCollection : Hashable {}
extension EnumCollection {
    static func all() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
}
