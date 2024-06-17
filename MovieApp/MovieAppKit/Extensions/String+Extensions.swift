//
//  String+Extensions.swift
//  MovieAppKit
//
//  Created by Thắng Đặng on 6/17/24.
//

import Foundation

extension String {
    var urlEncoded: String? {
        let allowedCharacterSet = NSCharacterSet.urlQueryAllowed
        let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        return encodedString
    }
}
