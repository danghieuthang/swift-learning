//
//  LocalizedError.swift
//  MVPatternValidationSummaryMessages
//
//  Created by Thắng Đặng on 6/5/24.
//

import Foundation

extension LocalizedError {
    var id: Int {
        localizedDescription.hashValue
    }
}
