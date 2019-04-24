//
//  Data+Extension.swift
//  Networking
//
//  Created by RI on 28/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
