//
//  FirebaseMock.swift
//  ReuseTests
//
//  Created by Julian Marzabal on 18/07/2023.
//

import Foundation
@testable import Reuse


class FirebaseMock: FirebaseProtocol {
    var response:(Result<UserModel, Error>) = .failure(APIError.invalidResponse)
    func register(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(response)
    }
    
    
}
