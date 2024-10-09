//
//  ProductRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation
import RxSwift

class ProductRepository {
    var productsList = BehaviorSubject<[Urunler]>(value: [Urunler]())
    
    func getProducts() {
        let productsURL = API.Endpoints.fetchProducts
        let url = URL(string: productsURL)!
        
        URLSession.shared.dataTask(with: url) { data,response,error in
            do {
                let response = try JSONDecoder().decode(UrunlerResult.self, from: data!)
                if let list = response.urunler {
                    self.productsList.onNext(list)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
