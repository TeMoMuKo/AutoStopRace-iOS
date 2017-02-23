//
//  PhraseTableViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import RxSwift

final class PhraseViewModel: PhraseViewModelType {
    let polishPhrase: Observable<String>
    let currentTranslationPhrase: Variable<String>
    let translationPhrases: Observable<[String]>
    
    init(phrase: Phrase) {
        polishPhrase = .just( phrase.polishPhrase )
        translationPhrases = .just( phrase.translationPhrases )
        currentTranslationPhrase = Variable<String>( phrase.translationPhrases[0] )
    }
    
}
