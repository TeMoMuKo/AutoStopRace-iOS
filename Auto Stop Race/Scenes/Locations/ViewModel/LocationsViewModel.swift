//
//  LocationsViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 23.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Moya_ObjectMapper
import Networking

final class LocationsViewModel {
    private let error = PublishSubject<String>()
    
    private let apiProvider = MoyaProvider<AsrApi>()
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
    
    func downloadTeamLocation(team: Team) {

        serviceProvider.apiService.fetchLocations(for: team.number) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let locationRecords):
                self.locationRecords.accept(locationRecords)
            case .failure:
                self.error.onNext("Request error. Try again later.")
            }
        }
//        let teamSlug = "team-\(team.teamNumber!)"
//        apiProvider.request(.userLocations(teamSlug)) { [weak self] result in
//            guard let `self` = self else { return }
//            switch result {
//            case let .success(response):
//                do {
//                    let locationRecords = try response.mapArray(LocationRecord.self)
//                    self.locationRecords.value = locationRecords.reversed()
//                } catch {
//                    self.error.onNext("Parsing error. Try again later.")
//                }
//            case .failure:
//                self.error.onNext("Request error. Try again later.")
//            }
//        }
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
