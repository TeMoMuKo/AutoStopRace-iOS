//
//  MenuCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SKPhotoBrowser

final class MenuCoordinator: Coordinator {

    var appCoordinator: AppCoordinator?
    var serviceProvider: ServiceProvider?

    convenience init(navigationController: UINavigationController?, appCoordinator: AppCoordinator?, serviceProvider: ServiceProvider ) {
        self.init(navigationController: navigationController)
        
        self.appCoordinator = appCoordinator
        self.serviceProvider = serviceProvider
    }
    
    let myNotification = Notification.Name(rawValue: "showMenu")
    
    var menuViewModel: MenuViewModel!
    var menuViewController: MenuViewController!
    
    func start() {
        let nc = NotificationCenter.default
        _ = nc.addObserver(forName: myNotification, object: nil, queue: nil, using: showMenu)
        menuViewModel = MenuViewModel(delegate: self, provider: serviceProvider!)
        menuViewController = MenuViewController(viewModel: menuViewModel)
    }
}

extension MenuCoordinator: MenuViewControllerDelegate {
    
    func showMenu(notification: Notification) {
        menuViewController.showMenu()
    }
    
    func menuSelected(menu: MenuDestination) {
        if menu == .teams && self.navigationController?.viewControllers.last is DashboardViewController {
            return
        }
        _ = self.navigationController?.popViewController(animated: false)

        switch menu {
        case .teams:
            let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: appCoordinator, serviceProvider: serviceProvider!)
            coordinator.start()
        case .locations:
            let coordinator = LocationsCoordinator(navigationController: navigationController, appCoordinator: appCoordinator, serviceProvider: serviceProvider!)
            coordinator.start()
        case .campus:
            var images = [SKPhoto]()
            let photo = SKPhoto.photoWithImage(#imageLiteral(resourceName: "campus_map"))
            images.append(photo)
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(0)
            self.navigationController?.present(browser, animated: true, completion: nil)
        case .schedule:
            var images = [SKPhoto]()
            let photo = SKPhoto.photoWithImage(#imageLiteral(resourceName: "harmonogram"))
            images.append(photo)
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(0)
            self.navigationController?.present(browser, animated: true, completion: nil)
        case .phrasebook:
            let prasebookViewModel = PhrasebookViewModel(provider: serviceProvider!)
            let phrasebookViewController = PhrasebookViewController(viewModel: prasebookViewModel)
            self.navigationController?.viewControllers = [phrasebookViewController]
        case .contact:
            let coordinator = ContactCoordinator(navigationController: navigationController)
            coordinator.start()
        case .partners:
            let partnersViewController = PartnersViewController()
            self.navigationController?.viewControllers = [partnersViewController]
        case .settings:
            let settingViewController = SettingsViewController(delegate: appCoordinator.self!, provider: serviceProvider!)
            self.navigationController?.viewControllers = [settingViewController]
        case .about:
            let aboutViewController = AboutViewController()
            self.navigationController?.viewControllers = [aboutViewController]
        }
    }
}

