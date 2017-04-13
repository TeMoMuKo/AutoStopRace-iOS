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
    
    var appCoordinator: AppCoordinator?
    var serviceProvider: ServiceProvider?
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?, serviceProvider: ServiceProvider ) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let viewModel = LoginViewModel(delegate: self, provider: serviceProvider!)
        let viewController = LoginViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func loginButtonTapped() {
        _ = navigationController?.popViewController(animated: true)
        let coordinator = UserLocationsCoordinator(navigationController: navigationController, appCoordinator: self.appCoordinator, serviceProvider:serviceProvider!)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
