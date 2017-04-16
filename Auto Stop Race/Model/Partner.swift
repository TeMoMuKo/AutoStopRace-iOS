//
//  Partner.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

enum PartnerCellType {
    case image, text
}
class Partner: NSObject {
    let cellType: PartnerCellType
    let value: String

    init(cellType: PartnerCellType, value: String) {
        self.cellType = cellType
        self.value = value
    }
}
