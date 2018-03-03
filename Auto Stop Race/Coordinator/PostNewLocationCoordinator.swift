//
//  NewLocationCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class PostNewLocationCoordinator: Coordinator {
    
    var appCoordinator: AppCoordinator?
    var serviceProvider: ServiceProvider?
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?, serviceProvider: ServiceProvider ) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let viewModel = PostNewLocationViewModel(delegate: self, provider: serviceProvider!)
        let viewController = PostNewLocationViewController(viewModel: viewModel)
        navigationController?.show(viewController, sender: nil)
    }
}

extension PostNewLocationCoordinator: PostNewLocationViewControllerDelegate {
    func showMapTapped() {
        
    }
    
    func backToLocationsScreen() {
        _ = navigationController?.popViewController(animated: true)
    }
}

