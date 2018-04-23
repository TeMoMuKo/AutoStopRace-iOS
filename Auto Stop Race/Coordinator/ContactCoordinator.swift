//
//  ContactCoordinator.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

final class ContactCoordinator: Coordinator {

    var baseViewController: ApplicationViewController

    init(baseViewController: ApplicationViewController ) {
        self.baseViewController = baseViewController
    }

    func start() {
        let viewModel = ContactViewModel(delegate: self)
        let contactViewController = ContactViewController(viewModel: viewModel)
        baseViewController.setMainController(viewController: UINavigationController(rootViewController: contactViewController))
    }
}

extension ContactCoordinator: ContactViewControllerDelegate {
    func contactSelected(contact: Contact) {

    }
}
