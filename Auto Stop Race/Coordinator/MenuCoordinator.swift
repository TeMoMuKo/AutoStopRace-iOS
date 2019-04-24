//
//  MenuCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

final class MenuCoordinator: Coordinator {

    var baseViewController: ApplicationViewController
    var serviceProvider: ServiceProvider

    init(baseViewController: ApplicationViewController, serviceProvider: ServiceProvider ) {
        self.baseViewController = baseViewController
        self.serviceProvider = serviceProvider
    }
    
    let myNotification = Notification.Name(rawValue: "showMenu")
    
    var menuViewModel: MenuViewModel!
    var menuViewController: MenuViewController!
    
    func start() {
        let nc = NotificationCenter.default
        _ = nc.addObserver(forName: myNotification, object: nil, queue: nil, using: showMenu)
        menuViewModel = MenuViewModel(delegate: self, provider: serviceProvider)
        menuViewController = MenuViewController(viewModel: menuViewModel)
    }
}

extension MenuCoordinator: MenuViewControllerDelegate {
    
    func showMenu(notification: Notification) {
        menuViewController.showMenu()
    }
    
    func menuSelected(menu: MenuDestination) {
        switch menu {
        case .teams:
            let coordinator = DashboardCoordinator(baseViewController: baseViewController, serviceProvider: serviceProvider)
            coordinator.start()
        case .locations:
            let coordinator = LocationsCoordinator(baseViewController: baseViewController, serviceProvider: serviceProvider)
            coordinator.start()
        case .campus:
            let coordinator = CampusCoordinator(baseViewController: baseViewController)
            coordinator.start()
        case .schedule:
            let coordinator = ScheduleCoordinator(baseViewController: baseViewController)
            coordinator.start()
        case .phrasebook:
            let prasebookViewModel = PhrasebookViewModel(provider: serviceProvider)
            let phrasebookViewController = PhrasebookViewController(viewModel: prasebookViewModel)
            baseViewController.setMainController(viewController: UINavigationController(rootViewController: phrasebookViewController))
        case .competitions:
            let competitionsViewController = CompetitionsViewController(nibName: "CompetitionsViewController", bundle: nil)
            competitionsViewController.apiService = serviceProvider.apiService
            baseViewController.setMainController(viewController: UINavigationController(rootViewController: competitionsViewController))
        case .contact:
            let coordinator = ContactCoordinator(baseViewController: baseViewController)
            coordinator.start()
        case .partners:
            let partnersViewController = PartnersViewController()
            baseViewController.setMainController(viewController: UINavigationController(rootViewController: partnersViewController))
        case .settings:
            let settingViewController = SettingsViewController(provider: serviceProvider)
            baseViewController.setMainController(viewController: UINavigationController(rootViewController: settingViewController))
        case .about:
            let aboutViewController = AboutViewController()
            baseViewController.setMainController(viewController: UINavigationController(rootViewController: aboutViewController))
        }
    }
}

