//
//  LocationImage.swift
//  Networking
//
//  Created by RI on 28/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

struct LocationImage {
    let key: String = "image"
    let filename: String = "test.jpeg"
    let data: Data
    let mimeType: String = "image/jpeg"

    init?(withImage image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
