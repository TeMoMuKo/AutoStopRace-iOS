//
//  File.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 17.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift

class Menu: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
enum MenuDestination: Int {
    case locations = 0, teams, campus, phrasebook, contact, partners, settings, about
}

final class MenuViewModel {
    
    private let disposeBag = DisposeBag()
    private weak var delegate: MenuViewControllerDelegate?

    let itemSelected = PublishSubject<IndexPath>()
     
    let menu = Observable.just([
        Menu(name: "title_my_team_locations", imageName: "ic_location_on_black"),
        Menu(name: "title_teams", imageName: "ic_map_black"),
        Menu(name: "title_campus", imageName: "ic_tent_black"),
        Menu(name: "title_phrasebook", imageName: "ic_message_black"),
        Menu(name: "title_contact", imageName: "ic_email_black"),
        Menu(name: "title_partners", imageName: "ic_favorite_black"),
        Menu(name: "title_settings", imageName: "ic_settings_black"),
        Menu(name: "title_about", imageName: "ic_info_black")
    ])
    
    init( delegate: MenuViewControllerDelegate) {
        self.delegate = delegate
        
        itemSelected
            .subscribe(onNext: { clickedIndex in
                self.delegate?.menuSelected(menu: MenuDestination(rawValue: clickedIndex.row)!)
            })
        .addDisposableTo(disposeBag)
    }
}
