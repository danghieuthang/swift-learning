//
//  StringExtensions.swift
//  TodoAppWithCoreData
//
//  Created by Thắng Đặng on 6/18/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
