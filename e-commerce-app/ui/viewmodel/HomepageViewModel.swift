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
    private var allProducts = [Urunler]()
    private let disposeBag = DisposeBag()
    
    init() {
        pRepo.productsList.subscribe(onNext: { products in
            self.allProducts = products
            self.productsList.onNext(products)
        }).disposed(by: disposeBag)
    }
    
    func getProducts(){
        pRepo.getProducts()
    }
    
    func filterProducts(by category: String) {
        if category == "All" {
            productsList.onNext(allProducts)
        } else {
            let filteredProducts = allProducts.filter { $0.kategori == category }
            productsList.onNext(filteredProducts)
        }
    }
    
    func searchProduct(productName: String) {
        if productName.isEmpty {
            productsList.onNext(allProducts)
        } else {
            let filteredProducts = allProducts.filter { $0.ad!.lowercased().contains(productName.lowercased()) }
            productsList.onNext(filteredProducts)
        }
    }
}
