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
        
    var allPhrases: [Phrase] = []
    
    let phrases = Variable<[(Phrase, PhraseViewModelType)]>([])
    
    lazy var allPhrasesObservable: Observable<[PhraseViewModelType]>  = self.phrases.asObservable().map { $0.map { $0.1 }}
    
    lazy var phrasesObservable: Observable<[PhraseViewModelType]>  = self.phrases.asObservable().map { $0.map { $0.1 }}
    
    init (provider: ServiceProviderType) {
        
        languages = provider.csvService.loadLanguages()
        allPhrases = provider.csvService.loadPhrases() as [Phrase]
        self.phrases.value = allPhrases.map { ($0, PhraseViewModel(phrase: $0)) }
        
    }
}
