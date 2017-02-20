//
//  ContactViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift

final class ContactViewModel {
    
    private let disposeBag = DisposeBag()
    private weak var delegate: ContactViewControllerDelegate?
    
    let itemSelected = PublishSubject<IndexPath>()
    
    let contacts = Observable.just([
        Contact(type: "phone_number", value: "+48698402117", imageName: "contact_phone", contactDescription: "Numer do organizatorów (alarmowy)"),
        Contact(type: "sms", value: "+48799448409", imageName: "contact_sms", contactDescription: "Numer do relacji SMS"),
        Contact(type: "email", value: "kontakt@autostoprace.pl", imageName: "contact_mail", contactDescription: "Email organizatorów"),
        Contact(type: "web_page", value: "www.autostoprace.pl", imageName: "contact_webpage", contactDescription: "Strona Internetowa"),
        Contact(type: "fan_page", value: "AutoStopRace", imageName: "contact_facebook", contactDescription: "Fanpage")
        ])
    
    init( delegate: ContactViewControllerDelegate) {
        self.delegate = delegate
    
        itemSelected
            .subscribe(onNext: { clickedContact in
                print(clickedContact)
                
                // self.delegate?.contactSelected(contact: clickedContact )
            })
            .addDisposableTo(disposeBag)
        
    }
}
