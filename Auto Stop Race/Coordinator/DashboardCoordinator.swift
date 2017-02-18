//
//  DashboardCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class DashboardCoordinator: Coordinator {
    
    var appCoordinator: AppCoordinator?
    
    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        let viewModel = DashboardViewModel(delegate: self)
        let viewController = DashboardViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func stop() {
        _ = navigationController?.popViewController(animated: true)
        appCoordinator?.dashboardCoordinatorCompleted(coordinator: self)
    }
}


extension DashboardCoordinator: DashboardViewControllerDelegate {
    func menuSelected() {

    }
}


