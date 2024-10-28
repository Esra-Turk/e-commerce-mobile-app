//
//  Favorites.swift
//  e-commerce-app
//
//  Created by Esra Türk on 16.10.2024.
//

import UIKit
import RxSwift

class Favorites: UIViewController {
    var favoriteProductsList = [FavoriteProduct]()
    var viewModel = FavoritesViewModel()
    let disposeBag = DisposeBag()
    var cartItemList = [CartItem]()

    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
             
        viewModel.favoriteProductsList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                self?.favoriteProductsList = products
                self?.favoritesTableView.reloadData()
            }).disposed(by: disposeBag)

    }

}

extension Favorites: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteProductsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteProductCell") as! FavoriteProductCell
        let product = favoriteProductsList[indexPath.row]
        
        cell.brandNameLabel.text = product.brand
        cell.productNameLabel.text = product.name
        cell.priceLabel.text = "\(Int(product.price)) ₺"
        ImageHelper.showImage(for: cell.productImageView, urlString: product.image)

        
        cell.onRemoveButtonTapped = { [weak self] in
            self?.viewModel.removeFavorite(by: product.name!, brandName: product.brand!)
        }
        
        
        cell.selectionStyle = .none
        cell.customView.layer.shadowColor = UIColor.gray.cgColor
        cell.customView.layer.shadowOpacity = 0.5
        cell.customView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.customView.layer.shadowRadius = 2
        cell.customView.layer.masksToBounds = false
    
        return cell
    }
}







