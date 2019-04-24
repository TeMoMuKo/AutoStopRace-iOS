//
//  User.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public struct User: Codable {
    public let id: Int
    public let email: String
    public let firstName: String
    public let lastName: String
    public let teamNumber: Int
}

