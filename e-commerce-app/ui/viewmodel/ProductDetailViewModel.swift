//
//  ProductDetailViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation
import RxSwift

class ProductDetailViewModel {
    var cartItemList = BehaviorSubject<[CartItem]>(value: [CartItem]())
    var cRepo = CartRepository()
    var disposeBag = DisposeBag()

    init() {
        cRepo.getCartItems()
        cartItemList = cRepo.cartItemList
    }

    
    func updateOrAddCartItem(name:String, photo:String, category:String, price:Int, brand:String, orderQuantity:Int){
        cRepo.updateOrAddCartItem(name: name, photo: photo, category: category, price: price, brand: brand, orderQuantity: orderQuantity)
        
        cRepo.getCartItems()
        cartItemList = cRepo.cartItemList
    }
    
}
