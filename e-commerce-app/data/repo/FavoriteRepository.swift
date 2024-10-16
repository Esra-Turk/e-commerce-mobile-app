//
//  FavoriteRepository.swift
//  e-commerce-app
//
//  Created by Esra Türk on 16.10.2024.
//

import Foundation
import CoreData
import UIKit

class FavoriteRepository {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addFavorite(productName: String, brandName: String, price: Int, imageUrl: String) {
        let favoriteProduct = FavoriteProduct(context: context)
        favoriteProduct.name = productName
        favoriteProduct.brand = brandName
        favoriteProduct.price = Double(price)
        favoriteProduct.image = imageUrl
        
        appDelegate.saveContext()
    }
    
    func removeFavorite(by productName: String, brandName: String) {
        let request: NSFetchRequest<FavoriteProduct> = FavoriteProduct.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@ AND brand == %@", productName, brandName)
            
        do {
            let results = try context.fetch(request)
            if let productToRemove = results.first {
                context.delete(productToRemove)
                appDelegate.saveContext()
            } else {
                print("Product not found")
            }
        } catch {
            print("Failed to fetch favorite for removal: \(error)")
        }
    }
        
    func isFavorite(productName: String, brandName: String) -> Bool {
        let request: NSFetchRequest<FavoriteProduct> = FavoriteProduct.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@ AND brand == %@", productName, brandName)
        
        do {
            let result = try context.fetch(request)
            return result.first != nil
        } catch {
            print("Failed to check if favorite: \(error)")
            return false
        }
    }
        
    func getAllFavorites() -> [FavoriteProduct] {
        let request: NSFetchRequest<FavoriteProduct> = FavoriteProduct.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
        
}

