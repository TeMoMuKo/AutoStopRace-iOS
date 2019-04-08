//
//  LastLocation.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Realm
import RealmSwift

@objcMembers public class LocationRecord: Object, Decodable {
    public dynamic var id: Int = 0
    public dynamic var latitude: Double = 0.0
    public dynamic var longitude: Double = 0.0
    public dynamic var address: String? = nil
    public dynamic var countryName: String? = nil
    public dynamic var countryCode: String? = nil
    public dynamic var imageUrl: String? = nil
    public dynamic var message: String? = nil
    public dynamic var createdAt: Date = Date()

    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case address
        case countryName
        case countryCode
        case imageUrl
        case message
        case createdAt
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        address = try? container.decode(String.self, forKey: .address)
        countryName = try? container.decode(String.self, forKey: .countryName)
        countryCode = try? container.decode(String.self, forKey: .countryCode)
        imageUrl = try? container.decode(String.self, forKey: .imageUrl)
        message = try? container.decode(String.self, forKey: .message)
        let dateString = try container.decode(String.self, forKey: .createdAt)
        if let date = DateFormatter.jsonApiDateFormat.date(from: dateString) {
            createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
    }

    override public static func primaryKey() -> String? {
        return "id"
    }
}
