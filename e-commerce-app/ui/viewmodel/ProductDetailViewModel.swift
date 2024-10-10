//
//  ProductDetailViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation

class ProductDetailViewModel {
    var cRepo = CartRepository()
    
    func addToCart(name:String, photo:String, category:String, price:Int, brand:String, orderQuantity:Int){
        cRepo.addToCart(name: name, photo: photo, category: category, price: price, brand: brand, orderQuantity: orderQuantity)
    }
    
}
