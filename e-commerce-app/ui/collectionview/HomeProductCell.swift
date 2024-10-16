//
//  HomeProductCell.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class HomeProductCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productReviewsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Urunler?
    var viewModel: HomepageViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let product = product, let viewModel = viewModel else { return }
         
         viewModel.toggleFavorite(product: product)
         updateFavoriteButton()
    }
    
    // Hücreyi yapılandırırken çağrılacak fonksiyon
    func configure(with product: Urunler, viewModel: HomepageViewModel) {
        self.product = product
        self.viewModel = viewModel
        updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        guard let product = product, let viewModel = viewModel else { return }
        let isFavorite = viewModel.isFavorite(product: product)
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
    }
    
}
