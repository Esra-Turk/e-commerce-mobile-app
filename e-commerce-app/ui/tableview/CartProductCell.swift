//
//  CartProductCell.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class CartProductCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func increaseQuantityButton(_ sender: UIButton) {
    }
    
    @IBAction func decreaseQuantityButton(_ sender: UIButton) {
    }
    
    var onRemoveButtonTapped: (() -> Void)?
    
    @IBAction func removeProductButton(_ sender: Any) {
        onRemoveButtonTapped?()
        
    }
    
    
}
