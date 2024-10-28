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
    var fRepo = FavoriteRepository()
    var productsList = BehaviorSubject<[Product]>(value: [Product]())
    private var allProducts = [Product]()
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
    
    func toggleFavorite(product: Product) {
        let productName = product.ad
        let brandName = product.marka

        if isFavorite(product: product) {
            fRepo.removeFavorite(by: productName!, brandName: brandName!)
        } else {
            fRepo.addFavorite(productName: productName!, brandName: brandName!, price: product.fiyat!, imageUrl: product.resim!)
        }
    }
    
    func isFavorite(product: Product) -> Bool {
        let productName = product.ad
        let brandName = product.marka

        return fRepo.isFavorite(productName: productName!, brandName: brandName!)
    }
    

}
