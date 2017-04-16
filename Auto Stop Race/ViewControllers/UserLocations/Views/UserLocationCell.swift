//
//  UserLocationCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class UserLocationCell: BaseUICollectionCell {
    
    static let Identifier = "UserLocationCell"
    
    var locationRecord: LocationRecord? {
        didSet {
            if let locationCountry = locationRecord?.country_code {
                countryLabel.text =  locationCountry
                countryLabel.backgroundColor = UIColor.init(string: locationCountry)
            }
            
            if let locationAdress = locationRecord?.address {
                addressLabel.text = locationAdress
            }
            
            if let locationMessage = locationRecord?.message {
                messageLabel.text = locationMessage
            }
            
            if let createdAt = locationRecord?.created_at {
                createdAtLabel.text = createdAt.toString(withFormat: "dd.MM \nHH:mm")
            }
        }
    }
    
    var countryLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blueMenu
        label.layer.cornerRadius = 25
        label.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        label.layer.masksToBounds = true
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        return label
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        label.textColor = UIColor.gray
        return label
    }()
    
    var createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textColor = UIColor.blueMenu
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
        label.textColor = UIColor.blueMenu
        return label
    }()
    
    
    var separator: UIView = {
        let separator = UIView(frame: CGRect.init())
        separator.backgroundColor = UIColor.gray
        return separator
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.backgroundColor = UIColor.grayBackgroundColor
        
        addSubview(countryLabel)
        addSubview(addressLabel)
        addSubview(messageLabel)
        addSubview(separator)
        addSubview(createdAtLabel)

        setupConstraints()
    }
    
    
    func setupConstraints() {
        createdAtLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-15)
            make.height.width.equalTo(50)
            make.centerY.equalTo(self)
        }
        
        countryLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.height.width.equalTo(50)
        }
        
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(countryLabel.snp.right).offset(15)
            make.top.equalTo(self.snp.top).offset(14)
            make.right.lessThanOrEqualTo(createdAtLabel.snp.left).offset(-15)
        }
        
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(countryLabel.snp.right).offset(15)
            make.top.equalTo(addressLabel.snp.bottom).offset(5)
            make.right.lessThanOrEqualTo(createdAtLabel.snp.left).offset(-15)
        }
        
        separator.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.width.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
