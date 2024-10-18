//
//  RegisterViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 17.10.2024.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {
    private let registerRepo = RegisterRepository()
    
    func register(email:String, password:String, completion: @escaping (Result<User,Error>) -> Void){
        registerRepo.register(email: email, password: password) { result in
            completion(result)
        }
        
    }
    
    func saveUserDetails(userId: String, fullName: String, email: String, completion: @escaping (Error?) -> Void) {
           registerRepo.saveUserDetails(userId: userId, fullName: fullName, email: email) { error in
               completion(error) // Sonucu ViewController'a iletir
           }
       }
    
    
}
