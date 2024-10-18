//
//  RegisterRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 18.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterRepository {

    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error)) // Hata durumu
            } else if let user = result?.user {
                completion(.success(user)) // Başarılı kayıt
            }
        }
    }
    
    func saveUserDetails(userId: String, fullName: String, email: String, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(userId).setData([
            "fullName": fullName,
            "email": email
        ]) { error in
            completion(error)
        }
    }
}
