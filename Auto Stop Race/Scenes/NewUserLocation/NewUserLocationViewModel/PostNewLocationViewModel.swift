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
import Networking

final class PostNewLocationViewModel {
    private let disposeBag = DisposeBag()
    
    private let serviceProvider: ServiceProviderType
    private var delegate: PostNewLocationViewControllerDelegate?

    init( delegate: PostNewLocationViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
    }
    
    func saveNewLocationToDatabase(newLocation: CreateLocationModel, locationImage: LocationImage?) {
        //serviceProvider.realmDatabaseService.addUnsentLocationRecord(locationRecord: newLocation)
        Toast.showPositiveMessage(message: NSLocalizedString("saved_location", comment: ""))
        postNewLocation(newLocation: newLocation, locationImage: locationImage)
    }
    
    func postNewLocation(newLocation: CreateLocationModel, locationImage: LocationImage?) {

        serviceProvider.apiService.postNewLocation(createLocationModel: newLocation, locationImage: locationImage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let locationRecords):
                print("test")
                //self.locationRecords.accept(locationRecords)
            case .failure:
                print("failure")
                //self.error.onNext("Request error. Try again later.")
            }
            DispatchQueue.main.async {
                self.backToLocationsScreen()
            }
        }

//        apiProvider.request(.postNewLocation(location: newLocation), completion: { [weak self] result in
//            guard let `self` = self else { return }
//
//            switch result {
//            case let .success(response):
//                let statusCode = response.statusCode
//
//                if let status = HttpStatus(rawValue: statusCode) {
//                    switch status {
//                    case .Created:
//                        Toast.showPositiveMessage(message: NSLocalizedString("sended_location", comment: ""))
//                        self.serviceProvider.realmDatabaseService.removeLocationRecord(locationRecord: newLocation)
//                    case .UnprocessableEntity:
//                        do {
////                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
////                            Toast.showNegativeMessage(message: error.errors)
//                        } catch {
//
//                        }
//                    case .Unauthorized:
//                        do {
////                            let error = try response.mapObject(ErrorResponse.self) as ErrorResponse
////                            Toast.showNegativeMessage(message: error.errors)
//                        } catch {
//
//                        }
//                    default:
//                        Toast.showHttpStatusError(status: status)
//                    }
//                }
//            case let .failure(error):
//                Toast.showNegativeMessage(message: error.localizedDescription)
//            }
//
//            self.backToLocationsScreen()
//        })
    }
    
    func backToLocationsScreen() {
        delegate?.backToLocationsScreen()
    }
}
