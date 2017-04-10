//
//  AppCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxReachability
import ReachabilitySwift
import Fabric
import Crashlytics
import GoogleMaps

final class AppCoordinator: Coordinator {
    let serviceProvider = ServiceProvider()
    let reachability = Reachability()
    let disposeBag = DisposeBag()
    
    func start() {
        try? reachability?.startNotifier()
        
        Fabric.with([Crashlytics.self])
        
        serviceProvider.authService.validateToken()
        
        reachability?.rx.isReachable
            .subscribe(onNext: { [weak self] isReachable in
                guard let `self` = self else { return }
                if isReachable {
                    self.serviceProvider.locationSyncService.synchronizeLocationsWithServer()
                }
            })
            .addDisposableTo(disposeBag)
        
        setupGMSServices()

        let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: self, serviceProvider: serviceProvider)
        coordinator.start()
        childCoordinators.append(coordinator)
    
        let menuCoordinator = MenuCoordinator(navigationController: navigationController, appCoordinator: self, serviceProvider: serviceProvider)
        menuCoordinator.start()
    }
    
    func dashboardCoordinatorCompleted(coordinator: DashboardCoordinator) {
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func setupGMSServices() {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            let GMSServicesAPIKey = dict["GMSServicesAPIKey"] as? String
            GMSServices.provideAPIKey(GMSServicesAPIKey!)
        }
    }
}

extension AppCoordinator: SettingsViewControllerDelegate {
    
    func logoutButtonTapped() {
        serviceProvider.userDefaultsService.clearAuth()
        self.serviceProvider.authService.logout()
        _ = self.navigationController?.popViewController(animated: false)
        let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: self, serviceProvider: serviceProvider)
        coordinator.start()
    }
    
}

