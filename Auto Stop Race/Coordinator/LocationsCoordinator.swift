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
    
    let baseViewController: ApplicationViewController
    let serviceProvider: ServiceProvider
    let locationViewModel: LocationsViewModel
    let locationMapViewController: LocationsMapViewController

    init(baseViewController: ApplicationViewController, serviceProvider: ServiceProvider ) {
        self.baseViewController = baseViewController
        self.serviceProvider = serviceProvider
        self.locationViewModel = LocationsViewModel(provider: serviceProvider)
        self.locationMapViewController = LocationsMapViewController(viewModel: locationViewModel)
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let locationsMapViewController =  UINavigationController(rootViewController: locationMapViewController)
        locationsMapViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("tabbar_map_title", comment: ""), image: UIImage(named: "tabbar/map"), tag: 0)
        let locationsListViewController = UINavigationController(rootViewController: LocationsListViewController(viewModel: locationViewModel))
        locationsListViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("tabbar_list_title", comment: ""), image: UIImage(named: "tabbar/list"), tag: 1)
        let controllers = [locationsMapViewController, locationsListViewController]
        tabBarController.viewControllers = controllers
        baseViewController.setMainController(viewController: tabBarController)
    }
    
    func startWithUserLocations( locationRecords: Variable<[LocationRecord]> ) {
        start()
        locationViewModel.locationRecords = locationRecords
    }
}
