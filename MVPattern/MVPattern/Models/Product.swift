//
//  Product.swift
//  MVPattern
//
//  Created by Thắng Đặng on 6/4/24.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let price: Double
}
