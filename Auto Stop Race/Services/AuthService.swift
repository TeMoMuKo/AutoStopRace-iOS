//
//  AuthService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift

enum AutenticationError: Error {
    case server
    case badReponse
    case badCredentials
}

enum AutenticationStatus {
    case none
    case error(AutenticationError)
    case user(String)
}

protocol AuthServiceType {
    func login(_ username:String, password: String) -> Observable<AutenticationStatus>
    func logout()
}

final class AuthService: BaseService, AuthServiceType {
    let status = Variable(AutenticationStatus.none)
    
    func login(_ username: String, password: String) -> Observable<AutenticationStatus> {

        return Variable(AutenticationStatus.none).asObservable()
    }
    
    func logout() {
        status.value = .none
    }
}
