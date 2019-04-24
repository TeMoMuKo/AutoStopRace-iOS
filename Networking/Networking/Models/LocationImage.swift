//
//  LocationImage.swift
//  Networking
//
//  Created by RI on 28/03/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import Foundation

public struct LocationImage {
    public let key: String = "image"
    public let filename: String = "test.jpeg"
    public let data: Data
    public let mimeType: String = "image/jpeg"

    public init?(withImage image: UIImage?) {
        guard let data = image?.normalizedImage().jpegData(compressionQuality: 0.25) else { return nil }
        self.data = data
    }

    public init?(withNormalizedImage image: UIImage?) {
        guard let data = image?.normalizedImage().jpegData(compressionQuality: 1.0) else { return nil }
        self.data = data
    }
}
