//
//  UIColor.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(string: String?) {
        let colors = [0xD50000, 0xC51162, 0x0091EA, 0x2979FF, 0xAA00FF, 0x6200EA, 0x0097A7, 0x64DD17, 0xFF6D00, 0xDD2C00, 0x33691E, 0x3D5AFE, 0x3D5AFE, 0x5D4037]
        
        guard let unwrappedString = string, !unwrappedString.isEmpty, let firstChar = unwrappedString.uppercased().first else {
            self.init(netHex: colors[0])
            return
        }
        
        if firstChar < "A" || firstChar > "Z" {
            self.init(netHex: colors[colors.count-1])
        } else {
            let colorIndex = Int( ( Double(colors.count - 1) * ( Double((String(firstChar).utf8.first)!) - Double("A".utf8.first!)) / ( Double("Z".utf8.first!) -  Double("A".utf8.first!))  ).rounded() )
            self.init(netHex: colors[colorIndex])
        }
    }
    
    open class var blueMenu: UIColor {
        get {
            return UIColor.init(netHex: 0x1976d2)
        }
    }
    
    open class var grayBackground: UIColor {
        get {
            return UIColor.init(netHex: 0xceced2)
        }
    }
    
    open class var success: UIColor {
        get {
            return UIColor.init(netHex: 0x5cb85c)
        }
    }
    
    open class var circleColor: UIColor {
        get {
            return UIColor.init(netHex: 0xD50000)
        }
    }
    
    open class var grayBackgroundColor: UIColor {
        get {
            return UIColor.init(netHex: 0xf7f7f7)
        }
    }
}
