//
//  AppCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift
import Reachability
import RxReachability
import Fabric
import Crashlytics
import GoogleMaps
import Firebase

final class AppCoordinator: Coordinator {
    let serviceProvider = ServiceProvider()
    let reachability = Reachability()
    let disposeBag = DisposeBag()
    
    func start() {
        try? reachability?.startNotifier()

        setupFirebase()

        Fabric.with([Crashlytics.self])
        
        serviceProvider.authService.validateToken()
        serviceProvider.locationSyncService.synchronizeLocationsWithServer()

        reachability?.rx.isReachable.subscribe(onNext: { [weak self] isReachable in
                guard let `self` = self else { return }
                if isReachable {
                    self.serviceProvider.locationSyncService.synchronizeLocationsWithServer()
                }
        }).disposed(by: disposeBag)
        
        setupGMSServices()

        let coordinator = DashboardCoordinator(navigationController: navigationController, appCoordinator: self, serviceProvider: serviceProvider)
        coordinator.start()
        childCoordinators.append(coordinator)
    
        let menuCoordinator = MenuCoordinator(navigationController: navigationController, appCoordinator: self, serviceProvider: serviceProvider)
        menuCoordinator.start()
    }

    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    func dashboardCoordinatorCompleted(coordinator: DashboardCoordinator) {
        if let index = childCoordinators.index(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func setupGMSServices() {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist") else { return }
        guard let dict = NSDictionary(contentsOfFile: path) else { return }
        let GMSServicesAPIKey = dict["GMSServicesAPIKey"] as? String
        GMSServices.provideAPIKey(GMSServicesAPIKey!)
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

