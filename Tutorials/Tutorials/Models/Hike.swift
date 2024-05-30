//
//  Hike.swift
//  Tutorials
//
//  Created by Thắng Đặng on 5/30/24.
//

import Foundation

struct Hike: Identifiable, Hashable {
    let id = UUID()
    let Name: String
    let Photo: String
    let Miles: Double
}
