//
//  HomeRouter.swift
//  learning
//
//  Created by Thắng Đặng on 5/29/24.
//

import Foundation
import UIKit

protocol HomeRouterInterface: AnyObject { }

final class HomeRouter: HomeRouterInterface {
    
    static func createModule(using navigationController: UINavigationController) -> HomeViewController {
        let router = HomeRouter()
        guard let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "homeVC") as? HomeViewController else { return HomeViewController() }
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        return view
    }
}
