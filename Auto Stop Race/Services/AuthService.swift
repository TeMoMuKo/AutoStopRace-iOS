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
    case logged
    case user(String)
}

protocol AuthServiceType {
    var isUserLoggedIn: Bool { get }
    func loginStatus() -> Variable<AutenticationStatus>
    func validateToken()
    func logout()
}

final class AuthService: BaseService, AuthServiceType {
    private let status = Variable(AutenticationStatus.none)
    var isUserLoggedIn: Bool = false
    private let disposeBag = DisposeBag()

    override init(provider: ServiceProviderType) {
        super.init(provider: provider)

        status
            .asObservable()
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .none:
                    self.isUserLoggedIn = false
                case .logged:
                    self.isUserLoggedIn = true
                default:
                    self.isUserLoggedIn = false
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func loginStatus() -> Variable<AutenticationStatus> {
        return status
    }
    
    func validateToken() {
        if self.provider.userDefaultsService.getUserData() != nil {
            status.value = .logged
        } else {
            status.value = .none
        }
    }
    
    func logout() {
        status.value = .none
    }
}
