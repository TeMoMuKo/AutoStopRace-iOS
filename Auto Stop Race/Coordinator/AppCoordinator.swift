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

    private var baseViewController: ApplicationViewController
    var childCoordinators = [Coordinator]()

    init(applicationController: UIViewController) {
        baseViewController = ApplicationViewController(rootViewController: applicationController)
    }

    let serviceProvider = ServiceProvider()
    let reachability = Reachability()
    let bag = DisposeBag()
    
    func start() {
        try? reachability?.startNotifier()

        Fabric.with([Crashlytics.self])
        
        serviceProvider.authService.validateToken()
        serviceProvider.locationSyncService.synchronizeLocationsWithServer()

        reachability?.rx.isReachable.subscribe(onNext: { [weak self] isReachable in
                guard let `self` = self else { return }
                if isReachable {
                    self.serviceProvider.locationSyncService.synchronizeLocationsWithServer()
                }
        }).disposed(by: bag)
        
        setupGMSServices()

        let dashboardCoordinator = DashboardCoordinator(baseViewController: baseViewController, serviceProvider: serviceProvider)
        dashboardCoordinator.start()
        childCoordinators.append(dashboardCoordinator)

        let menuCoordinator = MenuCoordinator(baseViewController: baseViewController, serviceProvider: serviceProvider)
        menuCoordinator.start()
        childCoordinators.append(menuCoordinator)
    }

    func setupGMSServices() {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist") else { return }
        guard let dict = NSDictionary(contentsOfFile: path) else { return }
        let GMSServicesAPIKey = dict["GMSServicesAPIKey"] as? String
        GMSServices.provideAPIKey(GMSServicesAPIKey!)
    }
}
