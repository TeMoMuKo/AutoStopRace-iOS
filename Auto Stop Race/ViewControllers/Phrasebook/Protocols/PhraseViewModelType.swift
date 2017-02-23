//
//  File.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import RxSwift

protocol PhraseViewModelType {
    var polishPhrase: Observable<String> { get }
    var currentTranslationPhrase: Variable<String> { get }
    var translationPhrases: Observable<[String]> { get }
}
