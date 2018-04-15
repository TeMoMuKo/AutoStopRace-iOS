//
//  LocationsCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift

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
        let locationsViewController = LocationsViewController(viewModel: locationViewModel)
        self.navigationController?.viewControllers = [locationsViewController]
    }
    
    func startWithUserLocations( locationRecords: Variable<[LocationRecord]> ) {
        let locationViewModel = LocationsViewModel(provider: serviceProvider!, locationRecords: locationRecords)
        let locationsViewController = LocationsViewController(viewModel: locationViewModel)
        locationsViewController.showUserMarkers()
        self.navigationController?.viewControllers = [locationsViewController]
    }
}
