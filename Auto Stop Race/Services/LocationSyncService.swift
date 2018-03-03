//
//  LocationSyncService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 10.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RealmSwift
import Moya

protocol LocationSyncServiceType {
    func synchronizeLocationsWithServer()
}

final class LocationSyncService: BaseService, LocationSyncServiceType {
    
    func synchronizeLocationsWithServer() {
        if self.provider.authService.isUserLoggedIn {
            let unsendLocationRecords = self.provider.realmDatabaseService.getUnsentLocationRecords()
            
            for unsendLocationRecord in unsendLocationRecords {
                
                let endpointClosure = {  (target: AsrApi) ->  Endpoint<AsrApi> in
                    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
                    return defaultEndpoint.adding(newHTTPHeaderFields:
                        [
                            "access-token": self.provider.userDefaultsService.getAuthAccessToken()!,
                            "client": self.provider.userDefaultsService.getAuthClient()!,
                            "uid": self.provider.userDefaultsService.getAuthUid()!
                        ])
                }
                
                let apiProvider = MoyaProvider<AsrApi>(endpointClosure: endpointClosure)
                
                apiProvider.request(.postNewLocation(location: unsendLocationRecord), completion: { [weak self] result in
                    guard let `self` = self else { return }
                    
                    switch result {
                    case let .success(response):
                        let statusCode = response.statusCode
                        
                        if let status = HttpStatus(rawValue: statusCode) {
                            switch status {
                            case .Created:
                                    Toast.showPositiveMessage(message: NSLocalizedString("sended_location", comment: ""))
                                    self.provider.realmDatabaseService.removeLocationRecord(locationRecord: unsendLocationRecord)
                            case .Unauthorized:
                                do {
                                    let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
                                    Toast.showNegativeMessage(message: error.errors)
                                } catch {
                                    
                                }
                            default:
                                Toast.showHttpStatusError(status: status)
                            }
                        }
                    case let .failure(error):
                        Toast.showNegativeMessage(message: error.localizedDescription)
                    }
                })
            }
        }
    }
}
