//
//  Theme+UIButton.swift
//  Auto Stop Race
//
//  Created by RI on 03/03/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

struct ButtonTheme {

    weak var button: UIButton?

    init(_ button: UIButton?) {
        self.button = button
        setupDefault()
    }

    private func setupDefault() {
        button?.layer.cornerRadius = 5
    }

    func blueWhiteUltraLight() {
        button?.backgroundColor = Theme.Color.blueMenu
        button?.setTitleColor(UIColor.white, for: .normal)
        button?.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
    }

    func whiteBlueUltraLight() {
        button?.setTitleColor(Theme.Color.blueMenu, for: .normal)
        button?.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
        button?.backgroundColor = UIColor.white
    }
}

extension UIButton {

    var theme: ButtonTheme {
        return ButtonTheme(self)
    }
}
