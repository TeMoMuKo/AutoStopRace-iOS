//
//  File.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PhrasebookViewModel {
    private let disposeBag = DisposeBag()
    
    let languages: Observable<[String]>
    var allPhrases = Variable<[PhraseViewModelType]>([])
    var phrases = Variable<[PhraseViewModelType]>([])
    
    init (provider: ServiceProviderType) {
        languages = provider.csvService.loadLanguages()
        allPhrases = provider.csvService.loadPhrases()
        phrases.value = allPhrases.value
    }
}
