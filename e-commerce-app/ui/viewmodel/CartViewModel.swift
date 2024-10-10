//
//  CartViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation

class CartViewModel {
    var cRepo = CartRepository()
    
    func getCartItems(){
        cRepo.getCartItems()
    }
    
}
