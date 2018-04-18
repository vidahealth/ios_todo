//
//  Date+Utility.swift
//  VidaFoundation
//
//  Created by Bart Chrzaszcz on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation

extension Date {
    public init?(year: Int, month: Int, day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone.current
        // This is the best I could come up with for initializing a date from inside the initializer... Seems a little hacky?
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        self.init(timeIntervalSinceNow: date.timeIntervalSinceNow)
    }
}
