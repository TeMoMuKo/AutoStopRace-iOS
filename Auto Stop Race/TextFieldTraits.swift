//
//  TextFieldTraits.swift
//  Auto Stop Race
//
//  Created by RI on 24/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

enum InputTextFieldTraits {
    case email
    case password
}

class TextFieldTraits {

    var traits: InputTextFieldTraits? {
        didSet {
            guard let traits = traits else { return }
            switch traits {
            case .email: email()
            case .password: password()
            }
        }
    }

    weak var inputTextField: UITextField?

    init(_ inputTextField: UITextField?) {
        self.inputTextField = inputTextField
    }

    private func email() {
        inputTextField?.clearButtonMode = .always
        inputTextField?.autocapitalizationType = .none
        inputTextField?.autocorrectionType = .no
        inputTextField?.keyboardType = .emailAddress
    }

    private func password() {
        inputTextField?.isSecureTextEntry = true
        inputTextField?.autocapitalizationType = .none
        inputTextField?.autocorrectionType = .no
    }

}

extension UITextField {
    func set(traits: InputTextFieldTraits) {
        TextFieldTraits(self).traits = traits
    }
}
