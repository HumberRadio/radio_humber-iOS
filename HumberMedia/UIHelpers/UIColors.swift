//
//  UIColors.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/12/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//
import UIKit

extension UIColor {
    static var humberLightBlue: UIColor {
        return color(0, green: 161, blue: 223, alpha: 1.0)
    }
    static var humberLightGreen: UIColor {
        return color(179, green: 211, blue: 53, alpha: 1.0)
    }
    static var humberLightYellow: UIColor {
        return color(255, green: 219, blue: 0, alpha: 1.0)
    }
    static var humberPurple: UIColor {
        return color(94, green: 13, blue: 139, alpha: 1.0)
    }
    static var humberMagenta: UIColor {
        return color(223, green: 70, blue: 97, alpha: 1.0)
    }
    static var humberNavy: UIColor {
        return color(98, green: 150, blue: 169, alpha: 1.0)
    }
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            red: 1.0 / 255.0 * CGFloat(red),
            green: 1.0 / 255.0 * CGFloat(green),
            blue: 1.0 / 255.0 * CGFloat(blue),
            alpha: CGFloat(alpha))
    }
    
    
    static var humberHawks: UIColor {
        return color(1, green: 8, blue: 36, alpha: 1.0)
    }
}
