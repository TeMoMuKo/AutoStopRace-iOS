//
//  ContactCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

final class ContactCoordinator: Coordinator {
    
    func start() {
        let viewModel = ContactViewModel(delegate: self)
        let contactViewController = ContactViewController(viewModel: viewModel)
        self.navigationController?.viewControllers = [contactViewController]
    }
}

extension ContactCoordinator: ContactViewControllerDelegate {
    func contactSelected(contact: Contact) {

    }
}
