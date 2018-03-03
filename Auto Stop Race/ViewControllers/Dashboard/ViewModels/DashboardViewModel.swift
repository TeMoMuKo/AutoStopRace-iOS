//
//  DashboardViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DashboardViewModel {
    private var delegate: DashboardViewControllerDelegate?

    init(delegate: DashboardViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func loginButtonTapped() {
        delegate?.loginButtonTapped()
    }
    
    func contactButtonTapped() {
        delegate?.contactButtonTapped()
    }
}
