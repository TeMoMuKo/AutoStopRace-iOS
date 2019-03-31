//
//  CreateLocationRequest.swift
//  Networking
//
//  Created by RI on 27/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class CreateLocationModel: RealmSwift.Object, Codable {
    @objc public dynamic var latitude: Double = 0.0
    @objc public dynamic var longitude: Double = 0.0
    @objc public dynamic var message: String = ""

    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case message
    }

    required convenience public init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        message = try container.decode(String.self, forKey: .message)
    }
 
}
