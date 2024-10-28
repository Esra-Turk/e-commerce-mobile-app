//
//  CartRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import Foundation
import RxSwift

class CartRepository {
    var cartItemList = BehaviorSubject<[CartItem]>(value: [CartItem]())
   
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
                let res = try JSONDecoder().decode(CartResult.self, from: data!)
                if let list = res.urunler_sepeti {
                    self.cartItemList.onNext(list)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func removeCartItem(cartID:Int){
        let removeCartItemURL = API.Endpoints.removeFromCart
        let username = API.User.userName
        
        var request = URLRequest(url: URL(string: removeCartItemURL)!)
        request.httpMethod = "POST"
        let postString = "sepetId=\(cartID)&kullaniciAdi=\(username)"
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
        
        var currentList = try! cartItemList.value()
        if let index = currentList.firstIndex(where: { $0.sepetId == cartID }) {
            currentList.remove(at: index)
        }

        cartItemList.onNext(currentList)
        
    }
    
    func updateOrAddCartItem(name: String, photo: String, category: String, price: Int, brand: String, orderQuantity: Int) {
        do {
            let currentCartItems = try cartItemList.value()
            let username = API.User.userName
            
            if let existingItem = currentCartItems.first(where: { $0.ad == name && $0.kullaniciAdi == username }) {
                let updatedOrderQuantity = (existingItem.siparisAdeti ?? 0) + orderQuantity
                
                if let cartId = existingItem.sepetId {
                    removeCartItem(cartID: cartId)
                }
                
                addToCart(name: name, photo: photo, category: category, price: price, brand: brand, orderQuantity: updatedOrderQuantity)
                
            } else {
                   addToCart(name: name, photo: photo, category: category, price: price, brand: brand, orderQuantity: orderQuantity)
               }
           } catch {
               print("Error retrieving cart items: \(error.localizedDescription)")
               return
           }
        
    }
}
