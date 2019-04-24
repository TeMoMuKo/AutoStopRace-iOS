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
    private var delegate: ContactViewControllerDelegate?
    
    let modelSelected = PublishSubject<Contact>()
    
    let contacts = Observable.just([
        Contact(type: "phone_number", value: "+48576243478", imageName: "contact_phone", contactDescription: "Numer do organizatorów (alarmowy)"),
        Contact(type: "sms", value: "+48799448409", imageName: "contact_sms", contactDescription: "Numer do relacji SMS"),
        Contact(type: "email", value: "kontakt@autostoprace.pl", imageName: "contact_mail", contactDescription: "Email organizatorów"),
        Contact(type: "web_page", value: "http://www.autostoprace.pl", optionalDisplayedValue: "www.autostoprace.pl", imageName: "contact_webpage", contactDescription: "Strona Internetowa"),
        Contact(type: "fan_page", value: "107460812611436", optionalDisplayedValue: "AutoStopRace", imageName: "contact_facebook", contactDescription: "Fanpage"),
        Contact(type: "instagram", value: "https://www.instagram.com/autostoprace/", optionalDisplayedValue: "Instagram", imageName: "contact_instagram", contactDescription: "Fanpage")
        ])
    
    init( delegate: ContactViewControllerDelegate) {
        self.delegate = delegate
    }
}
