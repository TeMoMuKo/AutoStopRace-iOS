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

    private let apiProvider = MoyaProvider<AsrApi>()
    private let serviceProvider: ServiceProviderType
    
    private let disposeBag = DisposeBag()

    let allTeams = Variable<[Team]>([])
    let shownTeams = Variable<[Team]>([])
    
    init(provider: ServiceProviderType) {
        self.serviceProvider = provider
        
        downloadTeams()
    }
    
    func downloadTeams() {
        apiProvider.request(.allTeams()) { [weak self] result in
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
