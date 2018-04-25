//
//  UIImageView.swift
//  Auto Stop Race
//
//  Created by RI on 25/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSString, NSData>()

extension UIImageView {

    func setImage(with imageURL: URL) {
        if let imageData = imageCache.object(forKey: imageURL.path as NSString) {
            if let previewImage = UIImage(data: imageData as Data) {
                self.image = previewImage
                return
            }
        }

        DispatchQueue.global(qos: .background).async {
            do {
                let imageData = try Data(contentsOf: imageURL)
                if imageData.count >= 0, let previewImage = UIImage(data: imageData) {
                    imageCache.setObject(imageData as NSData, forKey: imageURL.path as NSString)
                    DispatchQueue.main.async {
                        self.image = previewImage
                    }
                }
            } catch let error {
                print(error)
            }
        }
    }
}
