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
            let r = CGFloat((rgb >> 8) & 0xF) / 15.0
            let g = CGFloat((rgb >> 4) & 0xF) / 15.0
            let b = CGFloat(rgb & 0xF) / 15.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        case 6: // RRGGBB
            let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
            let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
            let b = CGFloat(rgb & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        case 8: // RRGGBBAA
            let r = CGFloat((rgb >> 24) & 0xFF) / 255.0
            let g = CGFloat((rgb >> 16) & 0xFF) / 255.0
            let b = CGFloat((rgb >> 8) & 0xFF) / 255.0
            let a = CGFloat(rgb & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)
        default:
            return nil
        }
    }
}
