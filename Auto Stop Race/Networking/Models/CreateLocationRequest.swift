//
//  CreateLocationRecordRequest.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 30.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateLocationRecordRequest: NSObject  {
    var latitude: Double!
    var longitude: Double!
    var message: String?
    var image: String?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    
    
    func toDictionary() -> [String: [String: Any] ] {
        let dictionary = ["location":
            [
            "latitude":self.latitude,
            "longitude":self.longitude,
            "message":self.message ?? "",
            "image":self.image ?? ""
            ]]
        return dictionary
    }
}
