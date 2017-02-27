//
//  Model.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

class Contact: NSObject {
    let type: String
    let value: String
    let imageName: String
    let contactDescription: String
    
    init(type: String, value: String, imageName: String, contactDescription: String) {
        self.type = type
        self.value = value
        self.imageName = imageName
        self.contactDescription = contactDescription
    }
}

enum ContactType {
    case email, phone_number, sms, web_page, fan_page
}
