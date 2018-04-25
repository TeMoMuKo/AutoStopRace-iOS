//
//  Tile.swift
//  Auto Stop Race
//
//  Created by RI on 25/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

typealias TileInsets = UIEdgeInsets

class Tile: UIView {

    var containerView: UIView?

    var topConstraint: NSLayoutConstraint?
    var leftConstraint: NSLayoutConstraint?
    var rightConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?

    var inset: TileInsets? {
        didSet {
            guard let view = containerView else { return }
            guard let inset = inset else { return}
            if oldValue != nil {
                topConstraint?.constant = inset.top
                bottomConstraint?.constant = -inset.bottom
                leftConstraint?.constant = inset.left
                rightConstraint?.constant = -inset.right
            } else {
                topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: inset.top)
                bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom)
                leftConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left)
                rightConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset.right)
                NSLayoutConstraint.activate([topConstraint, leftConstraint, bottomConstraint, rightConstraint].compactMap { $0 })
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

    }

    func fill(nib: UINib) {
        containerView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        guard let view = containerView else { return }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
