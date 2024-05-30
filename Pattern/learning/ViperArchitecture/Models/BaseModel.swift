//
//  BaseModel.swift
//  learning
//
//  Created by Thắng Đặng on 5/29/24.
//

import Foundation

struct BaseModel: Codable {
    var title: String
    var description: String
    
    static let exampleDummyModels = [
        BaseModel(title: "Dummy1", description: "Dummy1"),
        BaseModel(title: "Dummy2", description: "Dummy1"),
        BaseModel(title: "Dummy3", description: "Dummy1"),
        BaseModel(title: "Dummy4", description: "Dummy1")
    ]
}
