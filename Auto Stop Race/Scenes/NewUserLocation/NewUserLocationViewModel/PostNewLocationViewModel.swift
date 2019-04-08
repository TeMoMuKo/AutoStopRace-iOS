//
//  NewUserLocationViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift
import Networking

final class PostNewLocationViewModel {
    private let disposeBag = DisposeBag()
    
    private let serviceProvider: ServiceProviderType
    private var delegate: PostNewLocationViewControllerDelegate?

    init(delegate: PostNewLocationViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
    }
    
    func saveNewLocationToDatabase(newLocation: CreateLocationRecordRequest, locationImage: LocationImage?) {
        DispatchQueue.main.async {
            self.serviceProvider.realmDatabaseService.addUnsentLocationRecord(locationRecord: newLocation)
            Toast.showPositiveMessage(message: NSLocalizedString("saved_location", comment: ""))
        }
        postNewLocation(newLocation: newLocation, locationImage: locationImage)
    }
    
    func postNewLocation(newLocation: CreateLocationRecordRequest, locationImage: LocationImage?) {
        serviceProvider.apiService.postNewLocation(createLocationModel: newLocation, locationImage: locationImage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.serviceProvider.realmDatabaseService.removeLocationRecord(locationRecord: newLocation)
                    Toast.showPositiveMessage(message: NSLocalizedString("sended_location", comment: ""))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    Toast.showNegativeMessage(message: error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                self.backToLocationsScreen()
            }
        }
    }
    
    func backToLocationsScreen() {
        delegate?.backToLocationsScreen()
    }
}
