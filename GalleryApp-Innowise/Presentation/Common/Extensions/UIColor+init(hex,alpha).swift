//
//  UIColor+fromRGBString.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 5.10.25.
//

import UIKit

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        let length = hexSanitized.count
        switch length {
        case 3: // RGB
            let red = CGFloat((rgb >> 8) & 0xF) / 15.0
            let green = CGFloat((rgb >> 4) & 0xF) / 15.0
            let blue = CGFloat(rgb & 0xF) / 15.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        case 6: // RRGGBB
            let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
            let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
            let blue = CGFloat(rgb & 0xFF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        case 8: // RRGGBBAA
            let red = CGFloat((rgb >> 24) & 0xFF) / 255.0
            let green = CGFloat((rgb >> 16) & 0xFF) / 255.0
            let blue = CGFloat((rgb >> 8) & 0xFF) / 255.0
            let newAlpha = CGFloat(rgb & 0xFF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: newAlpha)
        default:
            return nil
        }
    }
}
