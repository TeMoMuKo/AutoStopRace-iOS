//
//  LocationRecord.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 04.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import ObjectMapper

struct LocationRecord: Mappable {
    var id: Int!
    var latitude: Double!
    var longitude: Double!
    var message: String!
    var address: String!
    var country: String!
    var country_code: String!
    var created_at: Date!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        message <- map["message"]
        address <- map["address"]
        country <- map["country"]
        country_code <- map["country_code"]
        created_at <- (map["created_at"], DateTransform())
    }
}
