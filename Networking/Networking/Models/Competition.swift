//
//  Competition.swift
//  Networking
//
//  Created by Bartłomiej Korpus on 13/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public struct Competition: Decodable {
    public let id: Int
    public let name: String
    public let description: String
}
