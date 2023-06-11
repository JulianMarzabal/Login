//
//  HomeViewModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import Foundation
import FirebaseAuth

protocol HomeViewModelDelegate:AnyObject {
    func toFirstView()
    func showPromptView()
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    func validateEmail(email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func validatePassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    
    func validateUser(email:String, password:String){
        Auth.auth().signIn(withEmail:email , password: password) { (authResult, error) in
            if let error = error {
                print("Authentication Error \(error)")
               
            } else {
                print("sucessfull auth")
                self.delegate?.toFirstView()
        
            }
            
        }
    }
}
