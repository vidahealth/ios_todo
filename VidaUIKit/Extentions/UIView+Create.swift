//
//  UIView+Create.swift
//  Brice Pollock
//
//  Created by Brice Pollock on 1/12/17.
//  Copyright © 2017 Brice Pollock. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    static func createInstanceFromNib<T: UIView>(owner: Any? = nil) -> T {
        let viewString = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        let nib = bundle.loadNibNamed(viewString, owner: owner, options: nil)
        guard let view = nib?.first as? T else {
            print("Unable to load \(viewString) from nib")
            return T()
        }
        return view
    }
}
