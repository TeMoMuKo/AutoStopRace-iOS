//
//  AuthService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Networking

enum AutenticationError: Swift.Error {
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
    func loginStatus() -> BehaviorRelay<AutenticationStatus>
    func validateToken()
    func logout()
}

final class AuthService: BaseService, AuthServiceType {
    private let status = BehaviorRelay(value: AutenticationStatus.none)
    var isUserLoggedIn: Bool = false

    private let tokenStorageProvider = TokenStorageProvider()

    private let disposeBag = DisposeBag()

    override init(provider: ServiceProviderType) {
        super.init(provider: provider)

        status
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .none:
                    self.isUserLoggedIn = false
                case .logged:
                    self.isUserLoggedIn = true
                default:
                    self.isUserLoggedIn = false
                }
            }).disposed(by: disposeBag)
    }
    
    func loginStatus() -> BehaviorRelay<AutenticationStatus> {
        return status
    }
    
    func validateToken() {
        if tokenStorageProvider.fetchToken() != nil { 
            status.accept(.logged)
        } else {
            status.accept(.none)
        }
    }

    func logout() {
        clearSession()
        status.accept(.none)
    }

    func clearSession() {
        tokenStorageProvider.clearToken()
        DispatchQueue.main.async {
            self.provider.realmDatabaseService.clearDatabase()
            self.provider.documentsDataService.removeImageFolderInDocuments()
        }
    }
}
