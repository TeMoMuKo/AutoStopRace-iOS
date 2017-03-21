//
//  ServiceProvider.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

protocol ServiceProviderType: class {
    var csvService: CsvServiceType { get }
    var authService: AuthServiceType { get }
    var userDefaultsService: UserDefaultsServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var csvService: CsvServiceType = CsvService(provider: self)
    lazy var authService: AuthServiceType = AuthService(provider: self)
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
}
