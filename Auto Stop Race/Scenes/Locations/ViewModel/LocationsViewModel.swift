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

final class LocationsViewModel {
    private let error = PublishSubject<String>()

    let teamSelected = PublishSubject<Team>()
    
    private let apiProvider = MoyaProvider<AsrApi>()
    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()

    let allTeams = Variable<[Team]>([])
    let shownTeams = Variable<[Team]>([])
    
    var locationRecords = Variable<[LocationRecord]>([])
    
    var userTeamNumber: Int?
    
    init(provider: ServiceProviderType) {
        self.serviceProvider = provider

        downloadTeams()
    }
    
    init(provider: ServiceProviderType, locationRecords: Variable<[LocationRecord]>) {
        self.serviceProvider = provider
        self.locationRecords.value = locationRecords.value
    }
    
    func downloadTeamLocation(team: Team) {
        let teamSlug = "team-\(team.teamNumber!)"
        apiProvider.request(.userLocations(teamSlug)) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case let .success(response):
                do {
                    let locationRecords = try response.mapArray(LocationRecord.self)
                    self.locationRecords.value = locationRecords.reversed()
                } catch {
                    self.error.onNext("Parsing error. Try again later.")
                }
            case .failure:
                self.error.onNext("Request error. Try again later.")
            }
        }
    }
    
    func downloadTeams() {
        apiProvider.request(.allTeams) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case let .success(response):
                do {
                    let teams = try response.mapArray(Team.self)
                    self.allTeams.value = teams
                } catch {
                    self.error.onNext("Parsing error. Try again later.")
                }
            case .failure:
                self.error.onNext("Request error. Try again later.")
            }
        }
    }
}
