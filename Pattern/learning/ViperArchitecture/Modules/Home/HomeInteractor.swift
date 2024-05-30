//
//  HomeInteractor.swift
//  learning
//
//  Created by Thắng Đặng on 5/29/24.
//

import Foundation

protocol HomeInteractorInterface: AnyObject {
    var datas: [BaseModel]? { get }
}

final class HomeInteractor: HomeInteractorInterface {
    
    var datas: [BaseModel]? {
        LocalService.shared.saveDummyData() // dummy datas saving here
        return LocalService.shared.readData()
    }
}
