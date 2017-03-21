//
//  AppCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    let serviceProvider = ServiceProvider()

    func start() {        
        let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: self)
        coordinator.start()
        childCoordinators.append(coordinator)
        
        let menuCoordinator = MenuCoordinator(navigationController: navigationController)
        menuCoordinator.start()
    }
    
    func  dashboardCoordinatorCompleted(coordinator: DashboardCoordinator) {
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}




