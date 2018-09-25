//
//  VidaAlertBuilder.swift
//  Vida
//
//  Created by Vasyl Khmil on 4/10/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import UIKit
import VidaFoundation

fileprivate extension VidaAlertBuilder {
    struct Const {
        struct Numbers {
            static let optimalActionsCount = 2
        }

        struct Strings {
            struct Warnings {
                static let noTitleAndMessage = "A message OR title is required to create an alert"
                static let noActionsForAlertType = "VidaAlert requires at least one action for style .alert in order to dismiss"
                static let actionsCountNotOptimal = "User Guidelines suggests keeping actions to \(Const.Numbers.optimalActionsCount)"
                static let noPopoverSourceForActionSheetType = "No popover source provided for `.actionSheet` alert type. This will cause a crash on pad devices"
                static let cancelButtonIncorrectOrder = "Cancel buttons should always be on the left for alerts according to apple guidelines."
            }
        }
    }
}

// `VidaAlertBuilder` is class that follow Builder design patter for building application alert.
// Check nethods documnetation for better usage understanding.

// Example:
// VidaAlertBuilder.makeBuilder(with: title, message: message, style: .actionSheet)
//     .action(title: "Action 1")
//     .action(title: "Action 2"){ doSomething() }
//     .destructive(title: "Destructive")
//     .cancel(title: "Cancel")
//     .build()
//     .show(from: container, source)

// The order you are calling methods `action`, `destructive`, `cancel` matter. In same way buttons on alert will be ordered.

class VidaAlertBuilder: NSObject {
    typealias ActionHandler = () -> Void

    // `alertController` is an internal variable of alert that builder are working on.
    fileprivate let alertController: UIAlertController

    // Internal initializer for creating the instance of `VidaAlertBuilder`. You should never try to use it outside. For instantiating from outside use static method `instantiate`.

    // :alertController - internal instance of `UIAlertController` that builder will be working on.
    fileprivate init(alertController: UIAlertController) {
        self.alertController = alertController
    }

    // Public function for instantiation of `VidaAlertBuilder` class.

    // :title - parameter will be used as a title of alert.
    // :message - parameter will be used as a message of alert.
    // :style - define a style of altert.
    class func makeBuilder(with title: String?, message: String?, style: UIAlertController.Style) -> VidaAlertBuilder {

        let internalAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        return VidaAlertBuilder(alertController: internalAlertController)
    }

    // Builder method, that add a button with style `action` to an alert.

    // :title - parameter will be used as a title of a button
    // :handler - closure that will be called on button press

    // return instance of current `VidaAlertBuilder` for continuing building
    @discardableResult
    func action(title: String?, handler: ActionHandler? = nil) -> VidaAlertBuilder {
        let alertAction = UIAlertAction(title: title, style: .default) { _ in
            handler?()
        }

        alertController.addAction(alertAction)

        return self
    }

    // Builder method, that add a button with style `destructive` to an alert.

    // :title - parameter will be used as a title of a button
    // :handler - closure that will be called on button press

    // return instance of current `VidaAlertBuilder` for continuing building
    @discardableResult
    func destructive(title: String?, handler: ActionHandler? = nil) -> VidaAlertBuilder {
        let alertAction = UIAlertAction(title: title, style: .destructive) { _ in
            handler?()
        }

        alertController.addAction(alertAction)

        return self
    }

    // Builder method, that add a button with style `cancel` to an alert.

    // :title - parameter will be used as a title of a button
    // :handler - closure that will be called on button press

    // return instance of current `VidaAlertBuilder` for continuing building
    @discardableResult
    func cancel(title: String?, handler: ActionHandler? = nil) -> VidaAlertBuilder {
        let alertAction = UIAlertAction(title: title, style: .cancel) { _ in
            handler?()
        }

        if alertController.preferredStyle == .alert && !alertController.actions.isEmpty {
            errorLog(Const.Strings.Warnings.cancelButtonIncorrectOrder)
        }

        alertController.addAction(alertAction)

        return self
    }

    // Method validate if building is possible and create an alert for displaying.

    // return instance of `VidaAlert` if validation passed or `nil` if validation failed
    func build() -> VidaAlert? {
        let builderValid = validateBulider()
        return builderValid ? alertController : nil
    }

    // Method validate if alert components are valid for building.

    // return indicator if state is valid
    fileprivate func validateBulider() -> Bool {
        return validateActionsNumber() && validateContent()
    }

    // Method validate if alert actions count is valid for building.

    // return indicator if actions count is valid
    fileprivate func validateActionsNumber() -> Bool {
        var isValid = true

        if alertController.preferredStyle == .alert {
            if alertController.actions.isEmpty {
                errorLog(Const.Strings.Warnings.noActionsForAlertType)
                isValid = false
            }

            if alertController.actions.count > Const.Numbers.optimalActionsCount {
                warningLog(Const.Strings.Warnings.actionsCountNotOptimal)
            }
        }

        return isValid
    }

    // Method validate if alert content is valid for building.

    // return indicator if content is valid
    fileprivate func validateContent() -> Bool  {
        var isValid = true

        if alertController.title == nil && alertController.message == nil {
            if alertController.preferredStyle == .alert {
                errorLog(Const.Strings.Warnings.noTitleAndMessage)
                isValid = false
            }
            else {
                warningLog(Const.Strings.Warnings.noTitleAndMessage)
            }
        }


        return isValid
    }
}
