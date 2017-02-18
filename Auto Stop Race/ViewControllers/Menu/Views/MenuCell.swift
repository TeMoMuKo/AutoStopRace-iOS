//
//  MenuCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: BaseCell {
    
    static let Identifier = "MenuCell"

    var menu: Menu? {
        didSet {
            if let menuName = menu?.name {
                nameLabel.text =  NSLocalizedString(menuName, comment: "")
                nameLabel.textColor = UIColor.white
            }
            if let imageName = menu?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.white
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.white
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.white
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
