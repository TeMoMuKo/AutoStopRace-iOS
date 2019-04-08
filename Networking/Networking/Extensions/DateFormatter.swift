//
//  DateFormatter.swift
//  Networking
//
//  Created by RI on 08/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let jsonApiDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
}
