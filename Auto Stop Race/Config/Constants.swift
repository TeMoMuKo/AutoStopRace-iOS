//
//  Constants.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

struct ApiConfig {
    static let baseURL = "https://api.autostoprace.pl/api/v2/"
    static let headerFieldToken = "access-token"
    static let headerFieldClient = "client"
    static let headerFieldUid = "uid"
    static let apiResetPassRedirectUrl = "http://autostoprace.pl"
    static let shareMapUrl = "https://mapa.autostoprace.pl/"
    static let imageUrl = "https://api.autostoprace.pl/uploads/location/image/"
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

struct DateFormat {
    static let jsonApi = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let fullMap = "HH:mm dd.MM"
}

struct UIConfig {
    
}

struct GMSConfig {
    static let initialLatitude = 51.108029
    static let initialLongitude = 14.270389
    static let initialZoom = 5.0
}

struct PhrasebookConfig {
    static let csvAsssetName = "phrasebook"
}

struct ContactConfig {
    static let csvAssetName = "contact_data"
}

// TODO Change YOUR_APP_ID_HERE
 
struct AboutConfig {
    static let appStoreRateUrl = "itms-apps://itunes.apple.com/gb/app/idYOUR_APP_ID_HERE?action=write-review&mt=8"
    static let appStoreShareUrl = "https://itunes.apple.com/us/app/myapp/idYOUR_APP_ID_HERE?ls=1&mt=8"
}
