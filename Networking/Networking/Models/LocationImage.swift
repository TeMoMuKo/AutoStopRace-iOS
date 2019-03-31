//
//  LocationImage.swift
//  Networking
//
//  Created by RI on 28/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public struct LocationImage {
    let key: String = "image"
    let filename: String = "test.jpeg"
    let data: Data
    let mimeType: String = "image/jpeg"

    public init?(withImage image: UIImage?) {
        guard let data = image?.normalizedImage().jpegData(compressionQuality: 0.25) else { return nil }
        self.data = data
    }
}
