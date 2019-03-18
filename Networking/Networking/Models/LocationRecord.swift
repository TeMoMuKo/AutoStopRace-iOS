//
//  LastLocation.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public struct LocationRecord: Codable {
    public let id: Int
    public let latitude: Double
    public let longitude: Double
    public let address: String?
    public let countryName: String?
    public let countryCode: String?
    public let imageUrl: String?
    public let message: String
    public let createdAt: String
}
