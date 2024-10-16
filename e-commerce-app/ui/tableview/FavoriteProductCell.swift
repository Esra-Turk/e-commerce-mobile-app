//
//  FavoriteProductsTableView.swift
//  e-commerce-app
//
//  Created by Esra Türk on 16.10.2024.
//

import UIKit

class FavoriteProductCell: UITableViewCell {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    var onRemoveButtonTapped: (() -> Void)?
    
    @IBAction func deleteFavoriteProduct(_ sender: Any) {
        onRemoveButtonTapped?()
        
    }
    
}
