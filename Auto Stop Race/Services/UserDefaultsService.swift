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
    func setUserData(user: User)
    func getUserData() -> User?
}

final class UserDefaultsService: BaseService, UserDefaultsServiceType {
    
    private var defaults: UserDefaults {
        return UserDefaults.standard
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
}
