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
    
    var menuViewModel: MenuViewModel!
    var menuViewController: MenuViewController!
    
    func start() {
        let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: self)
        coordinator.start()
        
        menuViewModel = MenuViewModel(delegate: self)
        menuViewController = MenuViewController(viewModel: menuViewModel)
        
        childCoordinators.append(coordinator)
    }
    
    func  dashboardCoordinatorCompleted(coordinator: DashboardCoordinator) {
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

extension AppCoordinator: MenuViewControllerDelegate {
    func menuSelected() {
        menuViewController.showMenu()
    }
    
    func menuSelected(menu: MenuDestination) {
        
        self.navigationController?.popViewController(animated: false)
        
        switch menu {
        case .teams:
            let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: self)
            coordinator.start()
            break
        case .locations:
            break
        case .campus:
            break
        case .phrasebook:
            break
        case .contact:
            break
        case .partners:
            let viewController = PartnersViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case .settings:
            break
        case .about:
            break
        }
    }
}
