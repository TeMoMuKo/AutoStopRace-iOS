//
//  TeamLocationCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 07.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TeamLocationCell: BaseUICollectionCell {
    
    static let Identifier = "TeamLocationCell"
    
    var team: Team? {
        didSet {
            if let teamNumber = team?.teamNumber {
                teamNumberLabel.text = "\(teamNumber)"
            }
            
            if let latitude = team?.lastLocation?.latitude, let longitude = team?.lastLocation?.longitude  {
                addressLabel.text = NSLocalizedString("last_location_record" , comment: "") + "\(latitude) \(longitude)"
            }
            
            if let teamLastLocationTime = team?.lastLocation?.created_at {
                timeLabel.text = teamLastLocationTime.toString()
            }
        }
    }
    
    var teamNumberLabel:UILabel = {
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
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightLight)
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        label.textColor = UIColor.gray
        return label
    }()
    
    var separator: UIView = {
        let separator = UIView(frame: CGRect.init())
        separator.backgroundColor = UIColor.gray
        return separator
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(teamNumberLabel)
        addSubview(addressLabel)
        addSubview(timeLabel)
        addSubview(separator)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        teamNumberLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.height.width.equalTo(50)
        }
        
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(teamNumberLabel.snp.right).offset(15)
            make.top.equalTo(self.snp.top).offset(14)
        }
        
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(teamNumberLabel.snp.right).offset(15)
            make.top.equalTo(addressLabel.snp.bottom).offset(5)
        }
        
        separator.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.width.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
