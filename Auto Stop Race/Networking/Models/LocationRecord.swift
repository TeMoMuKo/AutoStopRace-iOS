//
//  LocationRecord.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 04.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class LocationRecord: Object, Mappable {
    dynamic var id = 0
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var message = ""
    dynamic var address = ""
    dynamic var country = ""
    dynamic var country_code = ""
    dynamic var created_at: Date? = nil
    dynamic var image: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        message <- map["message"]
        address <- map["address"]
        country <- map["country"]
        country_code <- map["country_code"]
        created_at <- (map["created_at"], CustomDateFormatTransform(formatString: DateFormat.jsonApi))
        image <- map["image"]
    }
}
