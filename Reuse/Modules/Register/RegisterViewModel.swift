//
//  RegisterViewModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import Foundation
import FirebaseAuth
protocol RegisterViewDelegate:AnyObject {
    
    func  toLoginView()
    func toHomeView()
    
    
    
    
}


class RegisterViewModel {
    private var email: String = "" {
        didSet {
            print(email)
        }
    }
    private var password: String = ""
    private var passwordConfirm: String = ""
    private var name: String = ""
    private var lastname: String = ""
    
    
    
    var items:[Item] = []
    weak var delegate: RegisterViewDelegate?
    var onFinishLoading: (()-> Void)?
    
//    func registerUser(email:String,password:String, completion: @escaping (Result<User,Error>) ->Void){
//
//        Auth.auth().createUser(withEmail: email, password: password) { authResult,error in
//            if let error =  error {
//                print("Cannot create user")
//                completion(.failure(error))
//            } else if let user = authResult?.user {
//                print("user succesfully created")
//                completion(.success(user))
//            }
//
//        }
//
//    }
    
    func registerUser(completion: @escaping (Result<User,Error>) ->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Cannot create user")
                completion(.failure(error))
            }else if let user = authResult?.user {
                print("user succesfully created")
                completion(.success(user))
            }
            
            
        }
        
    }
    
    func registerButtonTapped() {
        // validar los campos
        
        registerUser { [weak self] result in
            switch result {
            case .success(let user):
                print("usuario creado con exito \(user)")
                self?.delegate?.toHomeView()
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        
            
            
        }
    }
    
    func onViewDidLoad(){
        items = []
        items.append(.label(text: "Name"))
        items.append(.input(text: "Introduce Your Name", handler: {[weak self] text in
            self?.name = text
        }))
        items.append(.label(text: "Lastname"))
        items.append(.input(text: "Introduce Your Lastname", handler: {[weak self] text in
            self?.lastname = text
        }))
        items.append(.label(text: "Email"))

        items.append(.input(text: "Introduce Email", handler: {[weak self] text in
            self?.email = text
        }))
        items.append(.label(text: "Password"))
        items.append(.input(text: "Create a  Password", handler: {[weak self] password in
            self?.password = password
        }))
        items.append(.label(text: "Confirm Password"))
        items.append(.input(text: "Confirm your password", handler: {[weak self] text in
            self?.passwordConfirm = text
        }))
        
        items.append(.label(text: ""))
        items.append(.button(text: "Register", handler: {[weak self] in
            //self?.delegate?.toHomeView()
            self?.registerButtonTapped()
            
        }))
       
    }
    
  
    
    
    
    enum Item{
        case label(text:String)
        case button(text:String,handler: ButtonHandler?)
        case input(text:String,handler: TextHandler?)
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
    
}