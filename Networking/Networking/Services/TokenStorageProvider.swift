//
//  TokenStorageProvider.swift
//  Networking
//
//  Created by RI on 30/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation
import KeychainAccess

private struct KeychainConstants {
    static let service = "com.piotrholub.Auto-Stop-Race"
    static let tokenKey = "token"
}

protocol TokenStorageProviderProtocol {
    func store(token: String)
    func fetchToken() -> String?
    func clearToken()
}

public struct TokenStorageProvider: TokenStorageProviderProtocol {

    public init() {}
    let keychain = Keychain(service: KeychainConstants.service)

    func store(token: String) {
        keychain[string: KeychainConstants.tokenKey] = token
    }

    public func fetchToken() -> String? {
        return keychain[KeychainConstants.tokenKey]
    }

    public func clearToken() {
        keychain[string: KeychainConstants.tokenKey] = nil
    }
}
