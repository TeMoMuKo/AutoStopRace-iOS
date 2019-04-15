//
//  LocationsViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Networking

final class LocationsViewModel {
    private let error = PublishSubject<String>()
    
    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()

    let allTeams = Variable<[Team]>([])
    let shownTeams = Variable<[Team]>([])
    
    var locationRecords = BehaviorRelay<[LocationRecord]>(value: [])
    
    var userTeamNumber: Int?
    
    init(provider: ServiceProviderType) {
        self.serviceProvider = provider

        downloadTeams()
    }
    
    init(provider: ServiceProviderType, locationRecords: Variable<[LocationRecord]>) {
        self.serviceProvider = provider
        self.locationRecords.accept(locationRecords.value)
    }
    
    func downloadTeamLocation(teamNumber: Int) {
        serviceProvider.apiService.fetchLocations(for: teamNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let locationRecords):
                self.locationRecords.accept(locationRecords)
            case .failure(let error):
                self.error.onNext(error.localizedDescription)
            }
        }
    }
    
    func downloadTeams() {
        serviceProvider.apiService.fetchTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                print(teams)
                self.allTeams.value = teams
            case .failure(let error):
                DispatchQueue.main.async {
                    Toast.showNegativeMessage(message: error.localizedDescription)
                }
            }
        }
    }
}
