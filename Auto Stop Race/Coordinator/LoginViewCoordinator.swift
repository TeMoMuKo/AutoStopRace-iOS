//
//  LoginViewCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {
    let serviceProvider = ServiceProvider()
    
    func start() {
        let viewModel = LoginViewModel(delegate: self, provider: serviceProvider)
        let viewController = LoginViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func loginButtonTapped() {
        
    }
}
