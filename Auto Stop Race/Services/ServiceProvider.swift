//
//  ServiceProvider.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Networking

protocol ServiceProviderType: class {
    var csvService: CsvServiceType { get }
    var authService: AuthServiceType { get }
    var userDefaultsService: UserDefaultsServiceType { get }
    var realmDatabaseService: RealmDatabaseServiceType { get }
    var locationSyncService: LocationSyncServiceType { get }
    var apiService: ApiServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var csvService: CsvServiceType = CsvService(provider: self)
    lazy var authService: AuthServiceType = AuthService(provider: self)
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
    lazy var realmDatabaseService: RealmDatabaseServiceType = RealmDatabaseService(provider: self)
    lazy var locationSyncService: LocationSyncServiceType = LocationSyncService(provider: self)
    lazy var apiService: ApiServiceType = ApiService(networkingDispatcher: NetworkingDispatcher())
}
