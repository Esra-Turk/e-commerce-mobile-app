//
//  CartViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation
import RxSwift

class CartViewModel {
    var cRepo = CartRepository()
    var cartItemList = BehaviorSubject<[UrunlerSepeti]>(value: [UrunlerSepeti]())
    
    init() {
        cartItemList = cRepo.cartItemList
    }
    
    func getCartItems(){
        cRepo.getCartItems()
    }
    
    func remevoCartItem(cartID:Int){
        cRepo.removeCartItem(cartID: cartID)
    }
    
    func clearCart() {
        guard let cartItems = try? cartItemList.value() else { return }
        for product in cartItems {
            if let cartID = product.sepetId {
                remevoCartItem(cartID: cartID)
            }
        }
    }
    
}
