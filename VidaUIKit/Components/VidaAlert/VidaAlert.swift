//
//  VidaAlert.swift
//  Vida
//
//  Created by Vasyl Khmil on 3/22/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import UIKit

// `VidaAlert` is a protocol that represent generic application alert
// `VidaAlert` is used to hide the full implementation of different kind of alerts and provide limited amount of methods to use. This will save from modifying builded by special builders alert.
// To chech how it works - check `VidaAlertBuilder.swift` file that hide system UIAlertController implementation under `VidaAlert` protocol.

@objc protocol VidaAlert {
    // This method should provide a possibility to show alert after it get complitelly builded by one of builder class.
    func show(from container: UIViewController?, _ source: UIView?)
}

