//
//  LocationsCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

final class LocationsCoordinator: Coordinator {
    
    func start() {
        let locationViewModel = LocationsViewModel()
        let viewController = LocationsViewController(viewModel: locationViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
