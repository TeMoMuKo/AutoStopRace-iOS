//
//  UserLocationCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Networking

final class UserLocationsCoordinator: Coordinator {

    var baseViewController: ApplicationViewController
    var navigationController: UINavigationController
    var serviceProvider: ServiceProvider
    
    init(baseViewController: ApplicationViewController, navigationController: UINavigationController, serviceProvider: ServiceProvider ) {
        self.baseViewController = baseViewController
        self.navigationController = navigationController
        self.serviceProvider = serviceProvider
    }

    func start() {
        let viewModel = UserLocationsViewModel(delegate: self, provider: serviceProvider)
        let viewController = UserLocationsViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension UserLocationsCoordinator: UserLocationsViewControllerDelegate {
    
    func showMapTapped( locationRecords: BehaviorRelay<[LocationRecord]> ) {
        let coordinator = LocationsCoordinator(baseViewController: baseViewController, serviceProvider: serviceProvider)
        coordinator.startWithUserLocations( locationRecords: locationRecords )
    }
    
    func postNewLocationTapped() {
        let coordinator = PostNewLocationCoordinator(navigationController: navigationController, serviceProvider: serviceProvider)
        coordinator.start()
    }
}

