//
//  LoginViewCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var serviceProvider: ServiceProvider
    
    init(navigationController: UINavigationController, serviceProvider: ServiceProvider ) {
        self.navigationController = navigationController
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let viewModel = LoginViewModel(serviceProvider: serviceProvider)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
