//
//  UIColorExtensions.swift
//  QuizRight
//
//  Created by Mayur on 8/13/19.
//  Copyright © 2019 Red Mayo. All rights reserved.
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
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    static let primaryOrange = UIColor(rgb: 0xE74C3C) // UIColor(rgb: 0xF25C33)
    static let primaryBlack = UIColor(rgb: 0x3A3F47)
    static let primaryGreen = UIColor(rgb: 0x28AD6D)
    
    static let lightOrange = UIColor(rgb: 0xFCB69F)
    static let fontWhite = UIColor(rgb: 0xF0F3F4)
    static let fontBlack = UIColor(rgb: 0x2C3E50)
    static let fontGray = UIColor(rgb: 0x5D6D7E)
    static let fontGrayLight = UIColor(rgb: 0xCACfD2)
}
