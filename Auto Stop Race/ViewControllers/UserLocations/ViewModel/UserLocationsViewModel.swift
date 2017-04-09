//
//  UserLocationsViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Moya_ObjectMapper

final class UserLocationsViewModel {
    private let error = PublishSubject<String>()

    private let apiProvider = MoyaProvider<AsrApi>()
    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()

    private var delegate: UserLocationsViewControllerDelegate?

    let itemSelected = PublishSubject<IndexPath>()
    
    let locationRecords = Variable<[LocationRecord]>([])
    
    init( delegate: UserLocationsViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
        
        itemSelected
            .subscribe(onNext: { clickedContact in
                print(clickedContact)
            })
            .addDisposableTo(disposeBag)
    }
    
    func downloadLocations() {
        let teamSlug = "team-\(serviceProvider.userDefaultsService.getUserData().teamNumber!)"
        apiProvider.request(.userLocations(teamSlug)) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(response):
                do {
                    let locationRecords = try response.mapArray(LocationRecord.self)
                    self.locationRecords.value = locationRecords
                } catch {
                    self.error.onNext("Parsing error. Try again later.")
                }
            case .failure:
                self.error.onNext("Request error. Try again later.")
            }
        }
    }
    
    func postNewLocationTapped() {
        self.delegate?.postNewLocationTapped()
    }
}
