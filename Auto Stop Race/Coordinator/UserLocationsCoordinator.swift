//
//  UserLocationCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class UserLocationsCoordinator: Coordinator {
    
    var appCoordinator: AppCoordinator?
    var serviceProvider: ServiceProvider?
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?, serviceProvider: ServiceProvider ) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let viewModel = UserLocationsViewModel(delegate: self)
        let viewController = UserLocationsViewController(viewModel: viewModel)
        navigationController?.show(viewController, sender: nil)
    }
}




extension UserLocationsCoordinator: UserLocationsViewControllerDelegate {
    func showMapTapped() {
        
    }
    
    func postNewLocationTapped() {
        let coordinator = PostNewLocationCoordinator(navigationController: navigationController, appCoordinator: self.appCoordinator, serviceProvider:serviceProvider!)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

