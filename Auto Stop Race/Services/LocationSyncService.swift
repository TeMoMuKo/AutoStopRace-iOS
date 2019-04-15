//
//  LocationSyncService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 10.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RealmSwift
import Networking

protocol LocationSyncServiceType {
    func synchronizeLocationsWithServer()
}

final class LocationSyncService: BaseService, LocationSyncServiceType {
    
    func synchronizeLocationsWithServer() {
        guard provider.authService.isUserLoggedIn else { return }

        DispatchQueue.main.async {
            let unsendLocationRecords = self.provider.realmDatabaseService.getUnsentLocationRecords()

            for unsendLocationRecord in unsendLocationRecords {
                let image = LocationImage(withImage: self.provider.documentsDataService.getImage(with: unsendLocationRecord.imageFileName))
                self.provider.apiService.postNewLocation(createLocationModel: unsendLocationRecord, locationImage: image) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            Toast.showPositiveMessage(message: NSLocalizedString("sended_location", comment: ""))
                            if unsendLocationRecord.imageFileName != "" {
                                self.provider.documentsDataService.removeImageFromDocuments(with: unsendLocationRecord.imageFileName)
                            }
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
