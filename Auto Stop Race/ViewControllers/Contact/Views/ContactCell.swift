//
//  ContactCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

class ContactCell: BaseCell {
    
    static let Identifier = "ContactCell"
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)                
    }
    
}
