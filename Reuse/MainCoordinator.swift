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
        let vm = FirstViewViewModel()
        let vc = FirstViewController(viewmodel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    func onPromptView() {
        let view = ReusePrompt(text: "", onTapped: {[weak self ] in
            guard let self = self else {return}
        })
        
       let vc = PopUpViewController(contentView: view)
        
        navigationController.pushViewController(vc, animated: true)
      
        
    }
    
}
extension MainCoordinator: HomeViewModelDelegate {
    func showPromptView(text: String) {
        let view = ReusePrompt(text: text, onTapped: {})
        let vc = PopUpViewController(contentView:view)
        navigationController.present(vc, animated: true)
    }
    
    func showPromptView() {
        onPromptView()
    }
    
    func toFirstView() {
        onFirstView()
    }
}
extension MainCoordinator: RegisterViewDelegate{
    func showError(text:String) {
        let view = ReusePrompt(text: text, onTapped: {})
        let vc = PopUpViewController(contentView:view)
        navigationController.present(vc, animated: true)
    }
    
    func toHomeView() {
       onFirstView()
    }
    
    func toLoginView() {
        onLoginView()
    }
    
    
}
