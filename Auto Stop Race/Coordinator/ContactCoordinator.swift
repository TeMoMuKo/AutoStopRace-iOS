//
//  ContactCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

final class ContactCoordinator: Coordinator {
    
    func start() {
        let viewModel = ContactViewModel(delegate: self)
        let viewController = ContactViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ContactCoordinator: ContactViewControllerDelegate {
    func contactSelected(contact: Contact) {
        
    }
}


