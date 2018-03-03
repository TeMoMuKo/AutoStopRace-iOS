//
//  File.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 17.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift

enum LoginState {
    case logged
    case unauthenticated
}

final class MenuViewModel {
    
    private let disposeBag = DisposeBag()
    private weak var delegate: MenuViewControllerDelegate?

    var loginStatus: Observable<AutenticationStatus>!
    
    let itemSelected = PublishSubject<IndexPath>()
    
    var menu = Variable<[Menu]>([])
    
    let unauthenticatedMenus = [
        Menu(name: "title_my_team_locations", imageName: "ic_location_on_black"),
        Menu(name: "title_teams", imageName: "ic_map_black"),
        Menu(name: "title_campus", imageName: "ic_tent_black"),
        Menu(name: "title_schedule", imageName: "ic_schedule"),
        Menu(name: "title_phrasebook", imageName: "ic_message_black"),
        Menu(name: "title_contact", imageName: "ic_email_black"),
        Menu(name: "title_partners", imageName: "ic_favorite_black"),
        Menu(name: "title_about", imageName: "ic_info_black")
    ]
    
    let loggedMenus = [
        Menu(name: "title_settings", imageName: "ic_settings_black")
    ]
    
    init( delegate: MenuViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        
        loginStatus = provider.authService.loginStatus().asObservable().catchErrorJustReturn(.none)
        
        loginStatus
            .asObservable()
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .none:
                    self.menu.value = self.unauthenticatedMenus
                case .logged:
                    self.menu.value = self.unauthenticatedMenus + self.loggedMenus
                default:
                    self.menu.value = self.unauthenticatedMenus
                }
            })
            .disposed(by: disposeBag)
        
        itemSelected
            .subscribe(onNext: { clickedIndex in
                self.delegate?.menuSelected(menu: MenuDestination(rawValue: clickedIndex.row)!)
            })
        .disposed(by: disposeBag)
    }
}
