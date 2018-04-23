//
//  NewLocationCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

final class PostNewLocationCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var serviceProvider: ServiceProvider
    
    init(navigationController: UINavigationController, serviceProvider: ServiceProvider ) {
        self.navigationController = navigationController
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let viewModel = PostNewLocationViewModel(delegate: self, provider: serviceProvider)
        let viewController = PostNewLocationViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension PostNewLocationCoordinator: PostNewLocationViewControllerDelegate {
    func showMapTapped() {
        
    }
    
    func backToLocationsScreen() {
//        _ = navigationController?.popViewController(animated: true)
    }
}

