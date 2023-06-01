//
//  MainCoordinator.swift
//  Reuse
//
//  Created by Julian Marzabal on 01/06/2023.
//

import Foundation
import UIKit


class MainCoordinator {
    var navigationController: UINavigationController
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
