//
//  RegisterViewModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
protocol RegisterViewDelegate:AnyObject {
    func  toLoginView()
    func toHomeView()
    func showError(text:String)
}


class RegisterViewModel {
     var email: String = "" {
        didSet {
            print(email)
        }
    }
    public var firebaseManager:FirebaseProtocol = FirebaseManager.shared
    var password: String = ""
    var passwordConfirm: String = ""
    var name: String = ""
    var surname: String = ""
    var docRef: DocumentReference!
    
    
    
    var items:[Item] = []
    weak var delegate: RegisterViewDelegate?
    var onFinishLoading: (()-> Void)?
  
    
    private func registerUser(completion: @escaping (Result<UserModel,Error>) ->Void) {
        firebaseManager.register(email: email, password: password,completion: completion)
        
    }
    
    func registerButtonTapped() {
        guard !name.isEmpty && !surname.isEmpty else {
            showError(text: "name or surname empty")
         return
        }
        
        
        guard !email.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty else {
            showError(text: "Incorrect email or password")
            return
            
        }
        guard password == passwordConfirm else {
            showError(text: "Passwords do not match")
            return
            
        }
        
            registerUser { [weak self] result in
                switch result {
                case .success(let user):
                    self?.saveName(user: user)
                    print("Usuario creado con éxito: \(user)")
                   
                    
                    self?.delegate?.toHomeView()
                case .failure(let error):
                    self?.showError(text: error.localizedDescription)
                }
            }
    }
    
    func showError(text:String) {
        delegate?.showError(text: text)
    }
    func saveName(user:UserModel){
        let data: [String:Any] = ["Name": name, "surname": surname]
        docRef = Firestore.firestore().collection("userNames").document(user.uid)
        docRef.setData(data) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("data save")
            }
        }
        
    }
    

    func onViewDidLoad(){
        items = []
        items.append(.label(text: "Name"))
        items.append(.input(text: "Introduce Your Name", inputType: .name, handler: {[weak self] text in
            self?.name = text
        }))
        items.append(.label(text: "Surname"))
        items.append(.input(text: "Introduce Your Surname", inputType: .surname, handler: {[weak self] text in
            self?.surname = text
        }))
        items.append(.label(text: "Email"))

        items.append(.input(text: "Introduce Email", inputType: .email, handler: {[weak self] text in
            self?.email = text
        }))
        items.append(.label(text: "Password"))
        items.append(.input(text: "Create a  Password", inputType: .password, handler: {[weak self] password in
            self?.password = password
        }))
        items.append(.label(text: "Confirm Password"))
        items.append(.input(text: "Confirm your password", inputType: .password, handler: {[weak self] text in
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
        case input(text:String,inputType: InputType,handler: TextHandler?)
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
