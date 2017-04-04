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
    
    func postNewLocation(newLocation: CreateLocationRecordRequest) {
        
        let endpointClosure = {  (target: AsrApi) ->  Endpoint<AsrApi> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields:
                [
                    "access-token": self.serviceProvider.userDefaultsService.getAuthAccessToken()!,
                    "client":self.serviceProvider.userDefaultsService.getAuthClient()!,
                    "uid":self.serviceProvider.userDefaultsService.getAuthUid()!
                ])
        }
        
        let apiProvider = MoyaProvider<AsrApi>(endpointClosure: endpointClosure)
                
        apiProvider.request(.postNewLocation(location: newLocation), completion: { [unowned self] result in
            switch result {
            case let .success(response):
                do {

                } catch {
                    
                }
            case .failure:
                break
            }
        })
    }
}
