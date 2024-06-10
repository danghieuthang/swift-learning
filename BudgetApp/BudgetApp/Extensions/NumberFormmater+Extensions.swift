//
//  NumberFormmater+Extensions.swift
//  BudgetApp
//
//  Created by Thắng Đặng on 6/10/24.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formmater = NumberFormatter()
        formmater.numberStyle = .currency
        return formmater
    }
}
