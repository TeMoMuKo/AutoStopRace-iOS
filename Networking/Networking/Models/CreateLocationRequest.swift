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

@objcMembers public class CreateLocationRecordRequest: RealmSwift.Object, Codable {
    public dynamic var id = UUID().uuidString
    public dynamic var latitude: Double = 0.0
    public dynamic var longitude: Double = 0.0
    public dynamic var message: String = ""

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

    override public static func primaryKey() -> String? {
        return "id"
    }
}
