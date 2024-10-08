//
//  HomepageViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation
import RxSwift

class HomepageViewModel {
    var pRepo = ProductRepository()
    var productsList = BehaviorSubject<[Urunler]>(value: [Urunler]())
    
    init() {
        pRepo.getProducts()
        productsList = pRepo.productsList
    }
    
    func getProducts(){
        pRepo.getProducts()
    }
    
}
