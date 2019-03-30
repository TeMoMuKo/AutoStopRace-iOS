//
//  LastLocation.swift
//  Networking
//
//  Created by RI on 18/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation
import RealmSwift

public class LocationRecord: Object, Codable {
    @objc public dynamic var id: Int
    @objc public dynamic var latitude: Double
    @objc public dynamic var longitude: Double
    @objc public dynamic var address: String?
    @objc public dynamic var countryName: String?
    @objc public dynamic var countryCode: String?
    @objc public dynamic var imageUrl: String?
    @objc public dynamic var message: String
    @objc public dynamic var createdAt: Date

    override public static func primaryKey() -> String? {
        return "id"
    }
}
