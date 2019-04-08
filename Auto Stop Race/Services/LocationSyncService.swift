//
//  LocationSyncService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 10.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocationSyncServiceType {
    func synchronizeLocationsWithServer()
}

final class LocationSyncService: BaseService, LocationSyncServiceType {
    
    func synchronizeLocationsWithServer() {
        guard provider.authService.isUserLoggedIn else { return }

        DispatchQueue.main.async {
            let unsendLocationRecords = self.provider.realmDatabaseService.getUnsentLocationRecords()

            for unsendLocationRecord in unsendLocationRecords {
                self.provider.apiService.postNewLocation(createLocationModel: unsendLocationRecord, locationImage: nil) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            Toast.showPositiveMessage(message: NSLocalizedString("sended_location", comment: ""))
                            self.provider.realmDatabaseService.removeLocationRecord(locationRecord: unsendLocationRecord)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            Toast.showNegativeMessage(message: error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}
