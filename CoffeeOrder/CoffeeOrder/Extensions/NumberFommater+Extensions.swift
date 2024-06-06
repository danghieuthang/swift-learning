//
//  NumberFommater.swift
//  CoffeeOrder
//
//  Created by Thắng Đặng on 6/5/24.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let fomatter = NumberFormatter()
        fomatter.numberStyle = .currency
        return fomatter
    }
}
