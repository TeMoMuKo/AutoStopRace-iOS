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
import CoreLocation

class TeamLocationCell: BaseUICollectionCell {
    
    static let Identifier = "TeamLocationCell"
    
    var team: Team? {
        didSet {
            if let teamNumber = team?.teamNumber {
                teamNumberLabel.text = "\(teamNumber)"
            }
            
            if let country = team?.lastLocation?.country {
                addressLabel.text = NSLocalizedString("last_location_record" , comment: "") + "\(country)"
            } else if let latitude = team?.lastLocation?.latitude, let longitude = team?.lastLocation?.longitude  {
                let location = CLLocationCoordinate2D.init(latitude:latitude, longitude:longitude)
                addressLabel.text = NSLocalizedString("last_location_record" , comment: "") + "\(location.dms.latitude), \(location.dms.longitude)"
            } else {
                addressLabel.text = NSLocalizedString("last_location_record" , comment: "") + NSLocalizedString("missing_location", comment: "")
            }
            
            if let teamLastLocationTime = team?.lastLocation?.created_at {
                timeLabel.text = teamLastLocationTime.toString(withFormat: "EEEE, MM-dd-yyyy HH:mm")
            } else {
                timeLabel.text = ""
            }
        }
    }
    
    var teamNumberLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
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
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
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
