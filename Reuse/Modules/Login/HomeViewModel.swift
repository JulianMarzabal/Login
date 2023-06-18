//
//  HomeViewModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

protocol HomeViewModelDelegate:AnyObject {
    func toFirstView()
    func showPromptView()
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    private var email: String = ""
    private var password: String = ""
    var onFinishLoading: (()->Void)?
    
    
    var items:[Item] = []
    

    enum Item{
        case label(text:String)
        case button(text:String,handler: ButtonHandler?)
        case input(text:String,inputType:InputType,handler: TextHandler?)
        var identifier: String {
            switch self {
            case .button:
                return ButtonWrapper.identifier
            case .input:
                return TextFieldWrapper.identifier
            case .label:
                return LabelWrapper.identifier
            }
        }
        
    }
    
    func onViewDidLoad() {
       items = []
        items.append(.label(text: "Email"))
        items.append(.input(text: "Introduce your email", inputType: .email, handler: {[weak self] text in
            self?.email = text
        }))
        items.append(.label(text: "Password"))
        items.append(.input(text: "Introduce your password", inputType: .password, handler: {[weak self] text in
            self?.password = text
        }))
        items.append(.label(text: ""))
        items.append(.button(text: "Login", handler: {[weak self] in
            self?.loginButtonPressed()
        }))
        items.append(.label(text: ""))
        items.append(.label(text: "Forgot you email or password?"))
        
      
    }
    
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("login error \(error.localizedDescription)")
            } else {
                self.delegate?.toFirstView()
            }
            
        }
    }
    
    
    
    
    func loginButtonPressed() {
        loginUser()
        if !email.isEmpty && !password.isEmpty {
            loginUser()
        }
        
    }
    func singinWithGoogle() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowScene = scene as? UIWindowScene,
              let presentingViewController = windowScene.windows.first?.rootViewController else {
            print("No se pudo obtener el controlador de vista principal.")
            return
            
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting:presentingViewController ) { SignInResult, error in
            guard let result = SignInResult else {
                print("error sigin google")
                return
            }
            
            self.delegate?.toFirstView()
        }
    }
    

    
    
    
    
}

