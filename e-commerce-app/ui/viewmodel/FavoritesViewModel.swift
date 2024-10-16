//
//  FavoritesViewModel.swift
//  e-commerce-app
//
//  Created by Esra Türk on 16.10.2024.
//

import Foundation
import RxSwift

class FavoritesViewModel {
    var fRepo = FavoriteRepository()
    var favoriteProductsList = BehaviorSubject<[FavoriteProduct]>(value: [])

    init() {
        loadAllFavorites()
        
        // Core datada bir değişiklik olduğunda bildirimi dinler
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave), name: .NSManagedObjectContextDidSave, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func contextDidSave(_ notification: Notification) {
        loadAllFavorites()
    }
    
    func loadAllFavorites() {
        let favorites = fRepo.getAllFavorites()
        favoriteProductsList.onNext(favorites)
        
    }
    
    func removeFavorite(by productName: String, brandName: String){
        fRepo.removeFavorite(by: productName, brandName: brandName)
       
    }
    

}
