//
//  ProfileViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 18.10.2024.
//

import Foundation

class ProfileViewModel {
    
    private let profileRepo = ProfileRepository()
    var user: UserProfile?
    
    func fetchUserData(completion: @escaping () -> Void) {
        profileRepo.fetchUserData { [weak self] profile in
            self?.user = profile
            completion()
        }
    }
    
    func signOutUser(completion: @escaping (Error?) -> Void) {
        profileRepo.signOutUser { error in
            completion(error)
        }
    }
}
