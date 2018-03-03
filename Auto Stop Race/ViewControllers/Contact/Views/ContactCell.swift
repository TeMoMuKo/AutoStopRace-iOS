//
//  ContactCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit

class ContactCell: BaseUICollectionCell {
    
    static let Identifier = "ContactCell"
    
    var contact: Contact? {
        didSet {
            valueLabel.text = contact?.optionalDisplayedValue != "" ? contact?.optionalDisplayedValue : contact?.value
            if let contactDescription = contact?.contactDescription {
                contactDescriptionLabel.text = contactDescription
                contactDescriptionLabel.textColor = UIColor.gray
            }
            if let imageName = contact?.imageName {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
        return label
    }()
    
    var contactDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        return label
    }()
    
    var separator = SeparatorView()

    override func setupViews() {
        super.setupViews()
        addSubview(valueLabel)
        addSubview(contactDescriptionLabel)
        addSubview(imageView)
        addSubview(separator)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.height.width.equalTo(25)
        }
        
        valueLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.snp.top).offset(14)
        }
        
        contactDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.top.equalTo(valueLabel.snp.bottom).offset(5)
        }
        
        separator.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.width.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
}
