//
//  LoginRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 18.10.2024.
//

import Foundation
import FirebaseAuth

class LoginRepository {
    
    private let auth = Auth.auth()
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user)) // Başarılı giriş
            }
        }
    }
    
}
