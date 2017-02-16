//
//  AppDelegate.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        let coordinator = AppCoordinator(navigationController: navigationController)
        
        coordinator.start()
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().barTintColor = UIColor.blueMenu

        application.statusBarStyle = .lightContent
        return true
    }


}

