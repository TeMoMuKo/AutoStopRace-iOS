//
//  DashboardCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class DashboardCoordinator: Coordinator {
    
    var appCoordinator: AppCoordinator?
    var serviceProvider: ServiceProvider?
    private let disposeBag = DisposeBag()

    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?, serviceProvider: ServiceProvider ) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        serviceProvider!.authService.loginStatus()
            .asObservable()
            .subscribe(onNext: { [weak self] status in
                guard let `self` = self else { return }

                switch status {
                case .none:
                    self.showDashboard()
                case .logged:
                    self.showUserLocations()
                default:
                    self.showDashboard()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showDashboard() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let viewModel = DashboardViewModel(delegate: self)
        let viewController = DashboardViewController(viewModel: viewModel)
        navigationController?.viewControllers = [viewController]
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func showUserLocations() {
        let coordinator = UserLocationsCoordinator(navigationController: navigationController, appCoordinator: self.appCoordinator, serviceProvider: serviceProvider!)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func stop() {
        _ = navigationController?.popViewController(animated: true)
        appCoordinator?.dashboardCoordinatorCompleted(coordinator: self)
    }
}

extension DashboardCoordinator: DashboardViewControllerDelegate {
    func loginButtonTapped() {
        let coordinator = LoginCoordinator(navigationController: navigationController, appCoordinator: appCoordinator, serviceProvider: serviceProvider!)
        coordinator.start()
    }
    
    func contactButtonTapped() {
        let coordinator = ContactCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
