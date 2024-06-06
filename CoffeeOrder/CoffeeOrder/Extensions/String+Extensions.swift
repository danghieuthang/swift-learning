//
//  String+Extensions.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/6/24.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }

    /// A Boolean value indicating whether a string has characters.
    var isNotEmpty: Bool {
        !isEmpty
    }

    func isLessThan(_ number: Double) -> Bool {
        if !isNumeric {
            return false
        }
        guard let value = Double(self) else {
            return false
        }
        return value < number
    }
}
