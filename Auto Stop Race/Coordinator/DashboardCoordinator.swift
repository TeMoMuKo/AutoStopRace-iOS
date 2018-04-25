//
//  DashboardCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift

final class DashboardCoordinator: Coordinator {

    var baseViewController: ApplicationViewController
    var navigationController = UINavigationController(rootViewController: UIViewController())
    var serviceProvider: ServiceProvider
    private let bag = DisposeBag()

    lazy var contactCoordinator = ContactCoordinator(baseViewController: baseViewController)
    lazy var loginCoordinator = LoginCoordinator(navigationController: navigationController, serviceProvider: serviceProvider)

    init(baseViewController: ApplicationViewController, serviceProvider: ServiceProvider ) {
        self.baseViewController = baseViewController
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        serviceProvider.authService.loginStatus()
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
            }).disposed(by: bag)
    }
    
    func showDashboard() {
        let viewModel = DashboardViewModel(delegate: self)
        let viewController = DashboardViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        baseViewController.setMainController(viewController: navigationController)
    }
    
    func showUserLocations() {
        let coordinator = UserLocationsCoordinator(baseViewController: baseViewController, navigationController: navigationController, serviceProvider: serviceProvider)
        coordinator.start()
        baseViewController.setMainController(viewController: navigationController)
    }
}

extension DashboardCoordinator: DashboardViewControllerDelegate {
    func loginButtonTapped() {
        loginCoordinator.start()
    }
    
    func contactButtonTapped() {
        contactCoordinator.start()
    }
}
