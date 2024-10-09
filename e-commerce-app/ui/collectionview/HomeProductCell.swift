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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    }
    
    
}
