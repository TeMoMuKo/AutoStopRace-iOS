//
//  User.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 21.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var id: Int!
    var teamNumber: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["data.id"]
        teamNumber <- map["data.team_number"]
        firstName <- map["data.first_name"]
        lastName <- map["data.last_name"]
        email <- map["data.email"]
    }
}
