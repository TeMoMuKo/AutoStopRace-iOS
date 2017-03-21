//
//  Constants.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

struct ApiConfig {
    static let baseURL = "http://asrapidev.robert-i.com"
    static let headerFieldToken = "access-token"
    static let headerFieldClient = "client"
    static let headerFieldUid = "uid"
}

struct UserDefaultsKeys {
    static let authToken = "auth_token"
    static let authClient = "auth_client"
    static let authUid = "auth_uid"
    static let locationSyncTimestamp = "location_sync_timestamp"
    static let currentUser = "current_user_json"
}

struct DatabaseConfig {
    static let name = "auto_stop_race"
    static let version = 1
}

struct UIConfig {
    
}

struct GMSConfig {
    
}

struct PhrasebookConfig {
    static let csvAsssetName = "phrasebook"
}

struct ContactConfig {
    static let csvAssetName = "contact_data"
}
