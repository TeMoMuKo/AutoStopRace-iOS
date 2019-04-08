//
//  UserLocationsViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Networking

final class UserLocationsViewModel {
    private let error = PublishSubject<String>()

    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()

    private var delegate: UserLocationsViewControllerDelegate?

    let itemSelected = PublishSubject<IndexPath>()
    let locationRecords = BehaviorRelay<[LocationRecord]>(value: [])
    
    init(delegate: UserLocationsViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
    }
    
    func downloadLocations() {
        serviceProvider.apiService.fetchUserLocations { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let locationRecords):
                self.locationRecords.accept(locationRecords)
                self.saveRemoteLocationsToLocalDatabase()
            case .failure:
                self.error.onNext("Request error. Try again later.")
                self.loadLocationsFromDatabase()
            }
        }
    }
    
    func loadLocationsFromDatabase() {
        DispatchQueue.main.async {
            self.locationRecords.accept(self.serviceProvider.realmDatabaseService.getLocationRecords())
        }
    }
    
    func saveRemoteLocationsToLocalDatabase() {
        DispatchQueue.main.async {
            for locationRecord in self.locationRecords.value {
                self.serviceProvider.realmDatabaseService.saveRemoteLocationsToLocalDatabase(locationRecord: locationRecord)
            }
        }
    }
    
    func postNewLocationTapped() {
        delegate?.postNewLocationTapped()
    }
    
    func showMapTapped() {
        delegate?.showMapTapped(locationRecords: locationRecords)
    }
}
