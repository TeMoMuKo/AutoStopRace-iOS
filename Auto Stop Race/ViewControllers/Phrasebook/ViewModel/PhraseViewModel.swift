//
//  PhraseTableViewModel.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import RxSwift

final class PhraseViewModel: PhraseViewModelType {
    let polishPhrase: Variable<String>
    let selectedLanguage: Variable<Int>
    let currentTranslationPhrase: Variable<String>
    let translationPhrases: Variable<[String]>
    
    init(phrase: Phrase) {
        polishPhrase = Variable<String>( phrase.polishPhrase )
        translationPhrases = Variable<[String]>( phrase.translationPhrases )
        selectedLanguage = Variable<Int>( phrase.selectedLanguage )
        currentTranslationPhrase = Variable<String>( phrase.translationPhrases[selectedLanguage.value] )
    }
}
