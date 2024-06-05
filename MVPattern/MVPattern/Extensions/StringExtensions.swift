//
//  StringExtensions.swift
//  MVPattern
//
//  Created by Thắng Đặng on 6/5/24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "^[a-zA-Z0-9._%±]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
