//
//  SharedUIComponents.swift
//  Auto Stop Race
//
//  Created by RI on 03/03/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

class SeparatorView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        backgroundColor = Theme.Color.separatorColor
    }
}

