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
        let vm = RegisterViewModel()
        vm.delegate = self
        
        let vc = RegisterViewController(viewmodel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    func onLoginView(){
        let vm = HomeViewModel()
        vm.delegate = self
        let vc = HomeViewController(viewmodel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onFirstView() {
        let vc = FirstViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    func onPromptView() {
        let view = ReusePrompt(onTapped: {[weak self ] in
            guard let self = self else {return}
        })
        
       let vc = PopUpViewController(contentView: view)
        
        navigationController.pushViewController(vc, animated: true)
      
        
    }
    
}
extension MainCoordinator: HomeViewModelDelegate {
    func showPromptView() {
        onPromptView()
    }
    
    func toFirstView() {
        onFirstView()
    }
}
extension MainCoordinator: RegisterViewDelegate{
    func toHomeView() {
       onFirstView()
    }
    
    func toLoginView() {
        onLoginView()
    }
    
    
}
