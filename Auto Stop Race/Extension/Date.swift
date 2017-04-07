//
//  Date.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 07.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "pl")
        return dateFormatter.string(from: self)
    }
}
