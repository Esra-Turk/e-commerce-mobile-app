//
//  LoginViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 17.10.2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    private var loginRepo = LoginRepository()
    
    func login(email:String, password:String, completion: @escaping (Result<User,Error>) -> Void) {
        loginRepo.login(email: email, password: password) { result in
            switch result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    
}
