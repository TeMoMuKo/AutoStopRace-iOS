//
//  UIImage.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.04.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func normalizedImage() -> UIImage {
        
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)
        
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
