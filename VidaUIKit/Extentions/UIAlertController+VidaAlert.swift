//
//  UIAlertController+VidaAlert.swift
//  Vida
//
//  Created by Vasyl Khmil on 4/11/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import UIKit
import VidaFoundation

// Addoption of default system `UIAlertController` alert to `VidaAlert` protocol.
// This allow to hive all `UIAlertController` implementation and minimize possibility of changes after `VidaAlertBuilder` will build it.

extension UIAlertController: VidaAlert {

    func show(from container: UIViewController? = nil, _ source: UIView? = nil) {
        DispatchQueue.main.async {
            let presenter = container ?? UIApplication.shared.keyWindow?.rootViewController?.topController

            if let source = source {
                self.popoverPresentationController?.sourceView = source
                self.popoverPresentationController?.sourceRect = source.bounds
            }
            else if let source = presenter?.view {
                self.popoverPresentationController?.sourceView = source
                self.popoverPresentationController?.sourceRect = CGRect(origin: source.center, size: .zero)
            }
            else if self.preferredStyle == .actionSheet && UIDevice.current.userInterfaceIdiom == .pad {
                // If two first options failed, to avoid application crash on ipad devices - finishing the call without showing anything
                fatalLog("App tried to present an action sheet on an iPad without a valid container or source.")
                return
            }

            presenter?.present(self, animated: true)

        }
    }
}
