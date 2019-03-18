//
//  UserDefaultsService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 21.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Networking

protocol UserDefaultsServiceType {
    func setAuthAccessToken(token: String)
    func setAuthUid(uid: String)
    func setAuthClient(client: String)
    func getAuthAccessToken() -> String?
    func getAuthClient() -> String?
    func getAuthUid() -> String?
    func clearAuth()
    func setUserData(user: User)
    func getUserData() -> User?
    func setAuthorizationHeaders(httpResponse: HTTPURLResponse)
    func setLastLocationsSyncTimestamp()
    func getLastLocationSyncTimestamp()
}

final class UserDefaultsService: BaseService, UserDefaultsServiceType {
    
    private var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func setAuthAccessToken(token: String) {
        self.defaults.set(token, forKey: UserDefaultsKeys.authToken)
    }
    
    func setAuthUid(uid: String) {
        self.defaults.set(uid, forKey: UserDefaultsKeys.authUid)
    }
    
    func setAuthClient(client: String) {
        self.defaults.set(client, forKey: UserDefaultsKeys.authClient)
    }
    
    func getAuthAccessToken() -> String? {
        return self.defaults.string(forKey: UserDefaultsKeys.authToken)
    }
    
    func getAuthClient() -> String? {
        return self.defaults.string(forKey: UserDefaultsKeys.authClient)
    }
    
    func getAuthUid() -> String? {
        return self.defaults.string(forKey: UserDefaultsKeys.authUid)
    }
    
    func clearAuth() {
        self.defaults.removeObject(forKey: UserDefaultsKeys.authToken)
        self.defaults.removeObject(forKey: UserDefaultsKeys.authUid)
        self.defaults.removeObject(forKey: UserDefaultsKeys.authClient)
        self.defaults.removeObject(forKey: UserDefaultsKeys.currentUser)
        self.provider.realmDatabaseService.clearDatabase()
    }

    func setAuthorizationHeaders(httpResponse: HTTPURLResponse) {
        
        if let token = httpResponse.allHeaderFields[ApiConfig.headerFieldToken] as? String {
            setAuthAccessToken(token: token)
        }
        
        if let client = httpResponse.allHeaderFields[ApiConfig.headerFieldClient] as? String {
            setAuthClient(client: client)
        }
        
        if let uid = httpResponse.allHeaderFields[ApiConfig.headerFieldUid] as? String {
            setAuthUid(uid: uid)
        }
        
    }
    func setUserData(user: User) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(user),
            let userString = String(data: data, encoding: .utf8) else { return }
        self.defaults.set(userString, forKey: UserDefaultsKeys.currentUser)
    }
    
    func getUserData() -> User? {
        guard let userJsonString = defaults.string(forKey: UserDefaultsKeys.currentUser),
            let jsonData = userJsonString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(User.self, from: jsonData)
    }
    
    func setLastLocationsSyncTimestamp() {
        
    }
    
    func getLastLocationSyncTimestamp() {
    
    }
}
