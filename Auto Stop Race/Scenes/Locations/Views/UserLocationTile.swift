//
//  LabelTile.swift
//  CityApp
//
//  Created by RI on 17/04/2018.
//  Copyright © 2018 Intive. All rights reserved.
//

import UIKit
import Networking

class UserLocationTile: Tile {

    var imageTapAction: ((String, String?) -> Void)?

    @IBOutlet private var locationImageView: UIImageView!
    @IBOutlet weak var tileLabelView: UIView!
    @IBOutlet private var tileLabel: UILabel!
    @IBOutlet weak var timeLabelView: UIView!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var locationLabelView: UIView!
    @IBOutlet var locationLabel: UILabel!

    var location: LocationRecord? {
        didSet {
            guard let location = location else { return }
            if let message = location.message,
                !message.isEmpty {
                tileLabelView.isHidden = false
                tileLabel.text = message
            }
            if let locationImage = location.imageUrl, let url = URL(string: locationImage) {
                locationImageView.isHidden = false
                locationImageView.setImage(with: url)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
                locationImageView.addGestureRecognizer(tapGesture)
            }
            timeLabelView.isHidden = false
            timeLabel.text = location.createdAt.toString(withFormat: "MM-dd-yyyy HH:mm")
            if let address = location.address,
                !address.isEmpty {
                locationLabelView.isHidden = false
                locationLabel.text = "📍 \(address)"
            }
        }
    }

    override func initialize() {
        fill(nib: UINib(nibName: "UserLocationTile", bundle: nil))
        setupView()
        clearPlaceholders()
        setupLabel()
    }

    private func setupView() {
        layer.cornerRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
    }

    private func clearPlaceholders() {
        tileLabel.text = ""
        timeLabel.text = ""
    }

    private func setupLabel() {
        tileLabel.numberOfLines = 0
    }

    @objc private func handleImageTap() {
        guard let location = location, let locationImageUrl = location.imageUrl else { return }
        imageTapAction?(locationImageUrl, location.message)
    }
}
