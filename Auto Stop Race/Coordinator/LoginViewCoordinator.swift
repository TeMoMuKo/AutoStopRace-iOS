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
    
    func start() {
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func loginButtonTapped() {
        
    }
}
