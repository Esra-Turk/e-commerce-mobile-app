//
//  CartRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation

class CartRepository {
    
    func addToCart(name:String, photo:String, category:String, price:Int, brand:String, orderQuantity:Int){
        let addToCartURL = API.Endpoints.addToCart
        var request = URLRequest(url: URL(string: addToCartURL)!)
        request.httpMethod = "POST"
        
        let postString = "ad=\(name)&resim=\(photo)&kategori=\(category)&fiyat=\(price)&marka=\(brand)&siparisAdeti=\(orderQuantity)&kullaniciAdi=\(API.User.userName)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            do {
                let res = try JSONDecoder().decode(CRUDResult.self, from: data!)
                print("success : \(res.success!)")
                print("message : \(res.message!)")
            } catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
}
