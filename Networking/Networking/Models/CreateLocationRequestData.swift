//
//  CreateLocationRequestData.swift
//  Networking
//
//  Created by RI on 15/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

struct CreateLocationRequestData: Codable {
    let latitude: Double
    let longitude: Double
    let message: String
}
