//
//  FirebaseRegister.swift
//  Reuse
//
//  Created by Julian Marzabal on 18/07/2023.
//

import Foundation
import FirebaseAuth

struct UserModel {
    var name: String
    var uid: String
}

protocol FirebaseProtocol {
    func register(email:String, password:String,completion: @escaping (Result<UserModel,Error>) ->Void)
}

class FirebaseManager: FirebaseProtocol {
    static let shared = FirebaseManager()
    func register(email:String, password:String,completion: @escaping (Result<UserModel,Error>) ->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Cannot create user")
                completion(.failure(error))
            }else if let user = authResult?.user {
                print("user succesfully created")
                completion(.success(UserModel(name: user.displayName ?? "USER", uid: user.uid )))
            }
    }
    }
    
}
