//
//  ErrorResponse.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 06.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import ObjectMapper

struct ErrorResponse: Mappable {
    var errors: String!

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        errors <- map["errors.0"]
    }
}
