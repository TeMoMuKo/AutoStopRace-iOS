//
//  PartnerTextCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit

class PartnerTextCell: BaseUICollectionCell {
    
    static let Identifier = "PartnerTextCell"
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        textLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
