//
//  PartnerCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

class PartnerCell: BaseUICollectionCell {
    
    static let Identifier = "PartnerCell"
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        
    }
    
}
