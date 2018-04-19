//
//  SettingsViewModel.swift
//  VidaToDo
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift

struct SettingsViewModel {
    struct Strings {
        static let reallyLongString = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    }
    var pages: Observable<[SettingsPageViewData]> {
        return Observable.just([
            SettingsPageViewData(text: "PAGE 1\n\n\(SettingsViewModel.Strings.reallyLongString)"),
            SettingsPageViewData(text: "PAGE 2\n\n\(SettingsViewModel.Strings.reallyLongString)"),
            SettingsPageViewData(text: "PAGE 3\n\n\(SettingsViewModel.Strings.reallyLongString)"),
            SettingsPageViewData(text: "PAGE 4\n\n\(SettingsViewModel.Strings.reallyLongString)"),
            SettingsPageViewData(text: "PAGE 5\n\n\(SettingsViewModel.Strings.reallyLongString)"),
            SettingsPageViewData(text: "PAGE 6\n\n\(SettingsViewModel.Strings.reallyLongString)"),
            ])
    }
}
