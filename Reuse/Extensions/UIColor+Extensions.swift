//
//  UIColor+Extensions.swift
//  Reuse
//
//  Created by Julian Marzabal on 11/06/2023.
//

import Foundation
import UIKit

extension UIColor {
    static var myDefaultColor: UIColor {
            let factor: CGFloat = 0.7 // Factor de oscurecimiento (80% del color original)
            return UIColor(red: 0.61 * factor, green: 0.61 * factor, blue: 0.76 * factor, alpha: 1.0)
        }
}
