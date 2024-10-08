//
//  Endpoints.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation

struct API {
    static let baseURL = "http://kasimadalan.pe.hu/urunler"

    struct Endpoints {
        static let fetchProducts = baseURL + "/tumUrunleriGetir.php"
        static let fetchCartItems = baseURL + "/sepettekiUrunleriGetir.php"
        static let addToCart = baseURL + "/sepeteUrunEkle.php"
        static let removeFromCart = baseURL + "/sepettenUrunSil.php"
        
        static func fetchProductImage(for imageName: String) -> String {
            return "\(baseURL)/resimler/\(imageName).png"
        }
    }
}
