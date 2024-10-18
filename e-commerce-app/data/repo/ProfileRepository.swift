//
//  ProfileRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 18.10.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileRepository {
    
    private let db = Firestore.firestore()
    
    func fetchUserData(completion: @escaping (UserProfile?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(nil)
            return
        }
        
        let userId = currentUser.uid
        let docRef = db.collection("users").document(userId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let fullName = document.data()?["fullName"] as? String
                let email = document.data()?["email"] as? String
                let userProfile = UserProfile(id: userId, fullName: fullName!, email: email!)
                completion(userProfile)
            } else {
                print("Kullanıcı belgesi bulunamadı: \(error?.localizedDescription ?? "Hata")")
                completion(nil)
            }
        }
    }
    
    func signOutUser(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
