//
//  AppCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator : Coordinator {
    
    func start() {
        var viewController: UIViewController!
        viewController = DashboardViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
