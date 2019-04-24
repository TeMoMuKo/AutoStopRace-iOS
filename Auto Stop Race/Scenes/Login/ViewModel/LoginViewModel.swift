//
//  LoginViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {
    private let error = PublishSubject<String>()

    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()

    var inputBackgroundColor: Driver<UIColor>!
    var credentialsValid: Driver<Bool>!
    var activityIndicator = Variable<Bool>(false)
    var email: Driver<String>!
    var password: Driver<String>!
    
    init(serviceProvider: ServiceProviderType) {
        self.serviceProvider = serviceProvider
    }
    
    func setUpAuthDetails( email: Driver<String>, password: Driver<String>) {
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
        serviceProvider.apiService.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.serviceProvider.userDefaultsService.setUserData(user: user)
                    self.serviceProvider.authService.loginStatus().accept(.logged)
                    Toast.showPositiveMessage(message: NSLocalizedString("msg_after_login", comment: "") + "\(user.firstName) \(user.lastName)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    Toast.showNegativeMessage(message: error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                self.activityIndicator.value = false
            }
        }
    }

    // TODO: Not working in Api
    func resetPassword(email: String) { }
}
