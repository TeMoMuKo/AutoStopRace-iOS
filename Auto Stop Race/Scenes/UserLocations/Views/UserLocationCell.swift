//
//  UserLocationCell.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import Networking

class UserLocationCell: BaseUICollectionCell {
    
    static let Identifier = "UserLocationCell"
    
    var locationRecord: LocationRecord? {
        didSet {
            if locationRecord?.imageUrl != nil {
                countryLabel.text = ""
                countryLabel.backgroundColor = Theme.Color.blueMenu
                imageView.image = UIImage(named: "ic_photo_camera_white")?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = UIColor.white
            } else if let locationCountry = locationRecord?.countryCode {
                countryLabel.text =  locationCountry
                countryLabel.backgroundColor = UIColor.init(string: locationCountry)
                imageView.image = nil
            } else {
                countryLabel.text = ""
                countryLabel.backgroundColor = UIColor.gray
                imageView.image = UIImage(named: "ic_location_on_black")?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = UIColor.white
            }
            
            if let locationAdress = locationRecord?.address {
                addressLabel.text = locationAdress
            } else {
                if let locationLongitude = locationRecord?.longitude, let locationLatitude = locationRecord?.latitude {
                    let location = CLLocationCoordinate2D.init(latitude: locationLatitude, longitude: locationLongitude)
                    addressLabel.text = "\(location.dms.latitude), \(location.dms.longitude)"
                }
            }
            
            if let locationMessage = locationRecord?.message {
                messageLabel.text = locationMessage
            }
            
            if let createdAt = locationRecord?.createdAt {
                createdAtDateLabel.text = createdAt.toString(withFormat: "dd.MM")
                createdAtTimeLabel.text = createdAt.toString(withFormat: "HH:mm")
                syncView.image = UIImage(named: "ic_cloud_done")?.withRenderingMode(.alwaysTemplate)
                syncView.tintColor = Theme.Color.blueMenu
            } else {
                createdAtDateLabel.text = ""
                createdAtTimeLabel.text = ""
                syncView.image = UIImage(named: "ic_cloud_off")?.withRenderingMode(.alwaysTemplate)
                syncView.tintColor = Theme.Color.blueMenu
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = Theme.Color.blueMenu
        label.layer.cornerRadius = 25
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.layer.masksToBounds = true
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        return label
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        label.textColor = UIColor.gray
        return label
    }()
    
    var createdAtDateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Theme.Color.blueMenu
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        return label
    }()
    
    lazy var syncView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var createdAtTimeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Theme.Color.blueMenu
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        label.textColor = Theme.Color.blueMenu
        return label
    }()
    
    var separator = SeparatorView()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = Theme.Color.grayBackgroundColor
        addSubview(countryLabel)
        addSubview(imageView)
        addSubview(addressLabel)
        addSubview(messageLabel)
        addSubview(separator)
        addSubview(stackView)
        stackView.addArrangedSubview(createdAtDateLabel)
        stackView.addArrangedSubview(syncView)
        stackView.addArrangedSubview(createdAtTimeLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self).offset(-15)
            make.height.width.equalTo(80)
            make.centerY.equalTo(self)
        }
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(countryLabel)
            make.height.width.equalTo(30)
        }
        
        countryLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.height.width.equalTo(50)
        }
        
        addressLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(countryLabel.snp.right).offset(15)
            make.top.equalTo(self.snp.top).offset(14)
            make.right.lessThanOrEqualTo(stackView.snp.left).offset(-15)
        }
        
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(countryLabel.snp.right).offset(15)
            make.top.equalTo(addressLabel.snp.bottom).offset(5)
            make.right.lessThanOrEqualTo(stackView.snp.left).offset(-15)
        }
        
        separator.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.width.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
