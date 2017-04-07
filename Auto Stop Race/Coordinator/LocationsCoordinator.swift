//
//  LocationsCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class LocationsCoordinator: Coordinator {
    
    var appCoordinator: AppCoordinator?
    var serviceProvider: ServiceProvider?
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?, serviceProvider: ServiceProvider ) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let locationViewModel = LocationsViewModel(provider: serviceProvider!)
        let viewController = LocationsViewController(viewModel: locationViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
