//
//  LoginViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Moya_ObjectMapper

final class LoginViewModel {
    private let error = PublishSubject<String>()

    private let apiProvider = MoyaProvider<AsrApi>()
    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()
    
    private weak var delegate: LoginViewControllerDelegate?
    
    var inputBackgroundColor: Driver<UIColor>!
    var credentialsValid: Driver<Bool>!
    var email: Driver<String>!
    var password: Driver<String>!
    
    init( delegate: LoginViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
    }
    
    func setUpAuthDetails( email: Driver<String>, password:Driver<String>) {
        let usernameValid = email
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.utf8.count > 3 && $0.contains("@") }
        
        let passwordValid = password
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.utf8.count > 3 }
        
        credentialsValid = Driver.combineLatest(usernameValid, passwordValid) { $0 && $1 }
        
        inputBackgroundColor = credentialsValid
            .map { $0 ? UIColor.white : UIColor.red }
        
    }
    
    func signIn(email: String, password: String) {
        apiProvider.request(.singIn(email: email, password: password), completion: { [unowned self] result in
            switch result {
            case let .success(response):
                do {
                    if let httpResponse = response.response as? HTTPURLResponse {
                        self.serviceProvider.userDefaultsService.setAuthorizationHeaders(httpResponse: httpResponse)
                    }
                
                    if let user = try response.mapObject(User.self) as? User {
                        self.serviceProvider.userDefaultsService.setUserData(user: user)
                    }
                    
                } catch {
                    self.error.onNext("Parsing error. Try again later.")
                }
            case .failure:
                self.error.onNext("Request error. Try again later.")
            }
        })
    }
}
