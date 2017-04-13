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

final class LoginViewModel {
    private let error = PublishSubject<String>()

    private let apiProvider = MoyaProvider<AsrApi>()
    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()
    
    private var delegate: LoginViewControllerDelegate?
    
    var inputBackgroundColor: Driver<UIColor>!
    var credentialsValid: Driver<Bool>!
    var activityIndicator = Variable<Bool>(false)
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
        activityIndicator.value = true
        apiProvider.request(.singIn(email: email, password: password), completion: { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                
                if let status = HttpStatus(rawValue: statusCode) {
                    switch status {
                    case .OK :
                        do {
                            if let httpResponse = response.response as? HTTPURLResponse {
                                self.serviceProvider.userDefaultsService.setAuthorizationHeaders(httpResponse: httpResponse)
                            }
                            let user = try response.mapObject(User.self) as User
                            self.serviceProvider.userDefaultsService.setUserData(user: user)
                            self.serviceProvider.authService.loginStatus().value = .logged
                            self.handleLogin()
                            Toast.showPositiveMessage(message: NSLocalizedString("msg_after_login", comment: "") + "\(user.firstName!) \(user.lastName!)")
                        } catch {
                            
                        }
                    case .Unauthorized:
                        do {
                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
                            Toast.showNegativeMessage(message: error.errors)
                        } catch {
                            
                        }
                    default:
                        Toast.showHttpStatusError(status: status)
                    }
                }
            case let .failure(error):
                Toast.showNegativeMessage(message: error.localizedDescription)
            }
            self.activityIndicator.value = false
        })
    }
    
    func resetPassword(email: String) {
        apiProvider.request(.resetPassword(email: email, redirectUrl: ApiConfig.apiResetPassRedirectUrl), completion: { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                
                if let status = HttpStatus(rawValue: statusCode) {
                    switch status {
                        
                    // TODO NOT WORKING IN API
                    
                    case .OK:
                        do {
                            
                        } catch {
                            
                        }
                    case .NotFound:
                        do {
                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
                            Toast.showNegativeMessage(message: error.errors)
                        } catch {
                            
                        }
                    case .Unauthorized:
                        do {
                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
                            Toast.showNegativeMessage(message: error.errors)
                        } catch {
                            
                        }
                    default:
                        Toast.showHttpStatusError(status: status)
                    }
                }
            case let .failure(error):
                Toast.showNegativeMessage(message: error.localizedDescription)
            }
        })
    }
    
    func handleLogin() {
        self.delegate!.loginButtonTapped()
    }
}
