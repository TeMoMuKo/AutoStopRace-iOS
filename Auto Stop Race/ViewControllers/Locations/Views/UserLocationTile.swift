//
//  LabelTile.swift
//  CityApp
//
//  Created by RI on 17/04/2018.
//  Copyright © 2018 Intive. All rights reserved.
//

import UIKit

class UserLocationTile: Tile {

    var imageTapAction: ((String, String) -> Void)?

    @IBOutlet private var locationImageView: UIImageView!
    @IBOutlet weak var tileLabelView: UIView!
    @IBOutlet private var tileLabel: UILabel!
    @IBOutlet weak var timeLabelView: UIView!
    @IBOutlet private var timeLabel: UILabel!

    var location: LocationRecord? {
        didSet {
            guard let location = location else { return }
            if !location.message.isEmpty {
                tileLabelView.isHidden = false
                tileLabel.text = location.message
            }
            if let locationImage = location.image, let url = URL(string: ApiConfig.imageUrl + "\(location.id)/" + locationImage) {
                locationImageView.isHidden = false
                locationImageView.setImage(with: url)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
                locationImageView.addGestureRecognizer(tapGesture)
            }
            if let createdAt = location.created_at?.toString(withFormat: "MM-dd-yyyy HH:mm") {
                timeLabelView.isHidden = false
                timeLabel.text = createdAt
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
        guard let location = location, let locationImage = location.image else { return }
        let url = ApiConfig.imageUrl + "\(location.id)/" + locationImage
        imageTapAction?(url, location.message)
    }
}
