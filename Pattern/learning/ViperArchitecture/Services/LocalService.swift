//
//  LocalService.swift
//  learning
//
//  Created by Thắng Đặng on 5/29/24.
//

import Foundation

final class LocalService {
    
    static let shared: LocalService = LocalService()
    
    func saveDummyData() {
        let dataKey = "dummyDatas"
        var dummyDatas: [BaseModel] = []
        for number in 0...10 {
            dummyDatas.append(BaseModel(title: "DummyTitle\(number)", description: "DummyDescription\(number)"))
        }
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(dataKey)
            
            do {
                if let encoded = try? JSONEncoder().encode(dummyDatas) { try encoded.write(to: fileURL) }
            } catch {
                fatalError("An error was taken on save progress")
            }
        }
    }
    
    func readData() -> [BaseModel]? {
        let dataKey = "dummyDatas"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(dataKey)
            do{
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode([BaseModel].self, from: stringContent.data(using: .utf8) ?? Data()) {
                    return decoded
                }
            } catch{
                fatalError("An error was taken on read progress")
                
            }
        }
        return []
    }
}
