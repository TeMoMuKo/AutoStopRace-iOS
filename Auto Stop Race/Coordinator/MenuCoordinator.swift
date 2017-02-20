//
//  MenuCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit


final class MenuCoordinator: Coordinator {

    let myNotification = Notification.Name(rawValue:"showMenu")

    var menuViewModel: MenuViewModel!
    var menuViewController: MenuViewController!
    
    func start() {
        let nc = NotificationCenter.default
        nc.addObserver(forName:myNotification, object:nil, queue:nil, using:showMenu)
        
        menuViewModel = MenuViewModel(delegate: self)
        menuViewController = MenuViewController(viewModel: menuViewModel)
    }
}

extension MenuCoordinator: MenuViewControllerDelegate {
    
    func showMenu(notification:Notification) -> Void  {
        menuViewController.showMenu()
    }
    
    func menuSelected(menu: MenuDestination) {
        
        if menu == .teams &&  self.navigationController?.viewControllers.last is DashboardViewController{
            return
        }
        
        _ = self.navigationController?.popViewController(animated: false)
        
        switch menu {
        case .teams:
            let coordinator = DashboardCoordinator(navigationController: navigationController)
            coordinator.start()
            break
        case .locations:
            break
        case .campus:
            let viewController = CampusViewController()
            self.navigationController?.present(viewController, animated: true, completion: nil)
            break
        case .phrasebook:
            break
        case .contact:
            let coordinator = ContactCoordinator(navigationController: navigationController)
            coordinator.start()
            break
        case .partners:
            let viewController = PartnersViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case .settings:
            break
        case .about:
            let viewController = AboutViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        }
    }
}
