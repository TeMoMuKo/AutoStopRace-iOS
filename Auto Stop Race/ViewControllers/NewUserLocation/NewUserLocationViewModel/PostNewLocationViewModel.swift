//
//  NewUserLocationViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift

final class PostNewLocationViewModel {
    private let disposeBag = DisposeBag()
    
    private let serviceProvider: ServiceProviderType
    private var delegate: PostNewLocationViewControllerDelegate?

    init( delegate: PostNewLocationViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
    }
}
