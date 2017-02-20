//
//  LoginViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift

final class LoginViewModel {
    private let disposeBag = DisposeBag()
    private weak var delegate: LoginViewControllerDelegate?
    
    init( delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
    }
}
