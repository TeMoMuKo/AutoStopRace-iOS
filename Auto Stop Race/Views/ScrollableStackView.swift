//
//  ScrollableStackView.swift
//  Auto Stop Race
//
//  Created by RI on 25/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

class ScrollableStackView: UIScrollView {

    var tiles = [Tile]() {
        didSet {
            for tile in tiles {
                addTile(tile: tile)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize() {
        self.addSubview(stackView)
        stackView.strechOnSuperview()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let rootView = self.superview {
            stackView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor).isActive = true
        }
    }

    let stackView: UIStackView = { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }(UIStackView())

    func addTile(tile: Tile) {
        stackView.addArrangedSubview(tile)
    }

    func clearTiles() {
        stackView.removeAllSubviews()
    }
}
