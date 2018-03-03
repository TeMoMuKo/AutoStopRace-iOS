//
//  NewUserLocationViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class PostNewLocationViewModel {
    private let disposeBag = DisposeBag()
    
    private let serviceProvider: ServiceProviderType
    private var delegate: PostNewLocationViewControllerDelegate?

    init( delegate: PostNewLocationViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
    }
    
    func saveNewLocationToDatabase(newLocation: CreateLocationRecordRequest) {
        serviceProvider.realmDatabaseService.addUnsentLocationRecord(locationRecord: newLocation)
        Toast.showPositiveMessage(message: NSLocalizedString("saved_location", comment: ""))
        postNewLocation(newLocation: newLocation)
    }
    
    func postNewLocation(newLocation: CreateLocationRecordRequest) {
        
        let endpointClosure = {  (target: AsrApi) ->  Endpoint<AsrApi> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields:
                [
                    "access-token": self.serviceProvider.userDefaultsService.getAuthAccessToken()!,
                    "client": self.serviceProvider.userDefaultsService.getAuthClient()!,
                    "uid": self.serviceProvider.userDefaultsService.getAuthUid()!
                ])
        }
        
        let apiProvider = MoyaProvider<AsrApi>(endpointClosure: endpointClosure)
                
        apiProvider.request(.postNewLocation(location: newLocation), completion: { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                
                if let status = HttpStatus(rawValue: statusCode) {
                    switch status {
                    case .Created:
                        Toast.showPositiveMessage(message: NSLocalizedString("sended_location", comment: ""))
                        self.serviceProvider.realmDatabaseService.removeLocationRecord(locationRecord: newLocation)
                    case .UnprocessableEntity:
                        do {
                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
                            Toast.showNegativeMessage(message: error.errors)
                        } catch {
                            
                        }
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
            
            self.backToLocationsScreen()
        })
    }
    
    func backToLocationsScreen() {
        delegate?.backToLocationsScreen()
    }
}
