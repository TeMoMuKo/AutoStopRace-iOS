//
//  UIImage.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

extension UIImage {
    func normalizedImage() -> UIImage {
        guard imageOrientation != .up else { return self}
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: rect)
        
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
