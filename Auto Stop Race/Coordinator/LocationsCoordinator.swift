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
    
    var baseViewController: ApplicationViewController
    var serviceProvider: ServiceProvider
    
    init(baseViewController: ApplicationViewController, serviceProvider: ServiceProvider ) {
        self.baseViewController = baseViewController
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let locationViewModel = LocationsViewModel(provider: serviceProvider)
        let locationsMapViewController =  UINavigationController(rootViewController: LocationsMapViewController(viewModel: locationViewModel))
        locationsMapViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("tabbar_map_title", comment: ""), image: UIImage(named: "tabbar/map"), tag: 0)
        let locationsListViewController = UINavigationController(rootViewController: LocationsListViewController(viewModel: locationViewModel))
        locationsListViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("tabbar_list_title", comment: ""), image: UIImage(named: "tabbar/list"), tag: 1)
        let controllers = [locationsMapViewController, locationsListViewController]
        tabBarController.viewControllers = controllers
        baseViewController.setMainController(viewController: tabBarController)
    }
    
    func startWithUserLocations( locationRecords: Variable<[LocationRecord]> ) {
        let tabBarController = UITabBarController()
        let locationViewModel = LocationsViewModel(provider: serviceProvider)
        let locationsMapViewController =  UINavigationController(rootViewController: LocationsMapViewController(viewModel: locationViewModel))
        let locationsListViewController = UINavigationController(rootViewController: LocationsListViewController(viewModel: locationViewModel))
        let controllers = [locationsMapViewController, locationsListViewController]
        tabBarController.viewControllers = controllers
        baseViewController.setMainController(viewController: tabBarController)
    }
}
