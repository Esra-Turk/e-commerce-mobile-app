//
//  CartRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation
import RxSwift

class CartRepository {
    var cartItemList = BehaviorSubject<[UrunlerSepeti]>(value: [UrunlerSepeti]())
    
    func addToCart(name:String, photo:String, category:String, price:Int, brand:String, orderQuantity:Int){
        let addToCartURL = API.Endpoints.addToCart
        let username = API.User.userName
        
        var request = URLRequest(url: URL(string: addToCartURL)!)
        request.httpMethod = "POST"
        let postString = "ad=\(name)&resim=\(photo)&kategori=\(category)&fiyat=\(price)&marka=\(brand)&siparisAdeti=\(orderQuantity)&kullaniciAdi=\(username)"
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
    
    func getCartItems(){
        let getItemsURL = API.Endpoints.fetchCartItems
        let username = API.User.userName
        
        var request = URLRequest(url: URL(string: getItemsURL)!)
        request.httpMethod = "POST"
        let postString = "kullaniciAdi=\(username)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            do {
                let res = try JSONDecoder().decode(SepetResult.self, from: data!)
                if let list = res.urunler_sepeti {
                    self.cartItemList.onNext(list)
                    print(list[0].sepetId!) //id 520
                    print(list[1].sepetId!) // id 521
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
