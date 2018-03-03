//
//  String.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

extension String {
    func getNumber() -> Int {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: ""))!
    }
}
