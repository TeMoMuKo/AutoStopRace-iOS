//
//  Date.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 07.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

extension Date {
    
    func toLocalTime() -> Date {
        let timeZone = NSTimeZone.local
        let seconds: TimeInterval = Double(timeZone.secondsFromGMT(for: self))
        let localDate = Date(timeInterval: seconds, since: self)
        return localDate
    }
    
    func toString(withFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale(identifier: "pl")
        return dateFormatter.string(from: self.toLocalTime())
    }
}
