//
//  CreateLocationRequest.swift
//  Networking
//
//  Created by RI on 27/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation
import RealmSwift

public class CreateLocationModel: Object, Codable {
    @objc public dynamic var latitude: Double
    @objc public dynamic var longitude: Double
    @objc public dynamic var message: String
}
