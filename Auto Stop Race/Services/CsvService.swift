//
//  CsvService.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import CSV
import RxSwift

protocol CsvServiceType {
    func loadLanguages() -> Observable<[String]>
    func loadPhrases() -> Variable<[PhraseViewModelType]>
}

final class CsvService: BaseService, CsvServiceType {
    
    func loadLanguages() -> Observable<[String]> {
        
        let bundle = Bundle.main
        var csv: CSV
        
        if let path = bundle.path(forResource: "phrasebook", ofType: "csv") {
            if let steam = InputStream(fileAtPath: path) {
                do {
                    csv = try CSV(stream: steam, hasHeaderRow: true)
                    return .just(csv.headerRow!)
                } catch {
                    print("Error reading csv file.")
                }
            }
        }
        return .just([])
    }
    
    func loadPhrases() -> Variable<[PhraseViewModelType]> {
        
        var phrases: [Phrase] = []
        var phrasesViewModels: [PhraseViewModel] = []
        
        let bundle = Bundle.main
        var csv: CSV
        
        if let path = bundle.path(forResource: "phrasebook", ofType: "csv") {
            if let steam = InputStream(fileAtPath: path) {
                do {
                    csv = try CSV(stream: steam, hasHeaderRow: true)
                    for row in csv {
                        let polishPhrase = row[0]
                        let translationPhrases = Array(row[1..<row.count])
                        phrases.append(Phrase.init(polishPhrase: polishPhrase, selectedLanguage: 0, currentTranslationPhrase: translationPhrases[0], translationPhrases: translationPhrases))
                    }
                } catch {
                    print("Error reading csv file.")
                }
            }
        }
        
        phrasesViewModels = phrases.map { PhraseViewModel(phrase: $0) }
        
        return Variable<[PhraseViewModelType]>(phrasesViewModels)
    }
}
