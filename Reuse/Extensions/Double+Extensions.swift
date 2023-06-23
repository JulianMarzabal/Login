//
//  Double+Extensions.swift
//  Reuse
//
//  Created by Julian Marzabal on 19/06/2023.
//

import Foundation
extension Double {
    func toPercentageString(decimalPlaces: Int = 2) -> String {
        let percentage = self * 100
        let formatString = "%.\(decimalPlaces)f%%"
        return String(format: formatString, percentage)
    }
}
