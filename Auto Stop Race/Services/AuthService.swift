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
    
    func checkTokenLifespan() {
        
//        let endpointClosure = { (target: AsrApi) -> Endpoint in
//            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
//            return defaultEndpoint.adding(newHTTPHeaderFields: ["access-token": self.provider.userDefaultsService.getAuthAccessToken()!, "client": self.provider.userDefaultsService.getAuthClient()!, "uid": self.provider.userDefaultsService.getAuthUid()!])
//        }
//        
//        let apiProvider = MoyaProvider<AsrApi>(endpointClosure: endpointClosure)
//        
//        apiProvider.request(.validateToken, completion: { [weak self] result in
//            guard let `self` = self else { return }
//            
//            switch result {
//            case let .success(response):
//                let statusCode = response.statusCode
//                
//                if let status = HttpStatus(rawValue: statusCode) {
//                    switch status {
//                    case .OK :
//                        do {
//                            if let httpResponse = response.response {
//                                self.provider.userDefaultsService.setAuthorizationHeaders(httpResponse: httpResponse)
//                            }
//                            let user = try response.mapObject(User.self) as User
//                            Toast.showPositiveMessage(message: NSLocalizedString("msg_after_login", comment: "") + "\(user.firstName!) \(user.lastName!)")
//                        } catch {
//                            
//                        }
//                        self.status.value = .logged
//                    case .Unauthorized:
//                        do {
//                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
//                            Toast.showNegativeMessage(message: error.errors)
//                        } catch {
//                            
//                        }
//                        self.status.value = .none
//                    default:
//                        Toast.showHttpStatusError(status: status)
//                        self.status.value = .none
//                    }
//                }
//            case let .failure(error):
//                Toast.showNegativeMessage(message: error.localizedDescription)
//                self.status.value = .none
//            }
//
//        })
    }
    
    func logout() {
        tokenStorageProvider.clearToken()
        DispatchQueue.main.async {
            self.provider.realmDatabaseService.clearDatabase()
        }
        status.accept(.none)
    }
}
