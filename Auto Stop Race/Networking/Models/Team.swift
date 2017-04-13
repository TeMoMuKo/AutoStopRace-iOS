//
//  Team.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 07.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import ObjectMapper

struct Team: Mappable {
    var id: Int!
    var slug: String!
    var lastLocation: LocationRecord!
    var teamNumber: Int!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        slug <- map["slug"]
        lastLocation <- map["last_location"]
        teamNumber = Int(String(slug.characters.last!))
    }
}
