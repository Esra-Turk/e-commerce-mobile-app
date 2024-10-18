//
//  UserProfile.swift
//  e-commerce-app
//
//  Created by Esra Türk on 18.10.2024.
//

import Foundation

class UserProfile {
    var id: String?
    var fullName: String?
    var email: String?
    
    init(id: String, fullName: String, email: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
    }
}
