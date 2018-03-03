//
//  File.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 21.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation

class Phrase: NSObject {
    let polishPhrase: String
    var selectedLanguage: Int
    var currentTranslationPhrase: String
    let translationPhrases: [String]
    
    init(polishPhrase: String, selectedLanguage: Int, currentTranslationPhrase: String, translationPhrases: [String]) {
        self.polishPhrase = polishPhrase
        self.selectedLanguage = selectedLanguage
        self.currentTranslationPhrase = currentTranslationPhrase
        self.translationPhrases = translationPhrases
    }
}
