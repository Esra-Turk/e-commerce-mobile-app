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
        getCartItems()
        cartItemList = cRepo.cartItemList
    }
    
    func getCartItems(){
        cRepo.getCartItems()
    }
    
    func remevoCartItem(cartID:Int){
        cRepo.removeCartItem(cartID: cartID)
        
        var currentList = try! cartItemList.value()
        if let index = currentList.firstIndex(where: { $0.sepetId == cartID }) {
            currentList.remove(at: index)
        }

        cartItemList.onNext(currentList)
    }
    
}
