//
//  AuthService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 27.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper

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
        if self.provider.userDefaultsService.getAuthAccessToken() != nil {
            checkTokenLifespan()
        } else {
            status.value = .none
        }
    }
    
    func checkTokenLifespan() {
        
        let endpointClosure = {  (target: AsrApi) ->  Endpoint<AsrApi> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: ["access-token": self.provider.userDefaultsService.getAuthAccessToken()!, "client":self.provider.userDefaultsService.getAuthClient()!, "uid":self.provider.userDefaultsService.getAuthUid()!])
        }
        
        let apiProvider = MoyaProvider<AsrApi>(endpointClosure: endpointClosure)
        
        apiProvider.request(.validateToken, completion: { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(response):
                do {
                    if let httpResponse = response.response as? HTTPURLResponse {
                        self.provider.userDefaultsService.setAuthorizationHeaders(httpResponse: httpResponse)
                    }
                    
                    if let user = try response.mapObject(User.self) as? User {
                        self.provider.userDefaultsService.setUserData(user: user)
                        Toast.showPositiveMessage(message: "Zalogowany jako \(user.firstName) \(user.lastName)")
                    }
                    
                    self.status.value = .logged
                } catch {
                    
                }
            case .failure:
                self.status.value = .none
                break
            }
        })
    }
    
    func logout() {
        status.value = .none
    }
}
