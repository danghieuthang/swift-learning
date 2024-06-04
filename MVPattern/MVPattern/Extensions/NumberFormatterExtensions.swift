//
//  NumberFormatterExtension.swift
//  MVPattern
//
//  Created by Thắng Đặng on 6/4/24.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
