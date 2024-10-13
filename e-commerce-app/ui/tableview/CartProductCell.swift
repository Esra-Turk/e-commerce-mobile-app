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
    @IBOutlet weak var removeProductButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let interaction = UIContextMenuInteraction(delegate: self)
        removeProductButton.isUserInteractionEnabled = true
        removeProductButton.addInteraction(interaction)
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

extension CartProductCell: UIContextMenuInteractionDelegate {
    
    // Context Menu
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            
            let deleteAction = UIAction(title: "Sil", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                self.onRemoveButtonTapped?()  // Silme işlemi tetikleniyor
            }
            
            let addToFavoritesAction = UIAction(title: "Sil ve Favorilere Ekle", image: UIImage(systemName: "heart")) { action in
                print("Favorilere ekle butonuna basıldı")
            }
            
            let cancelAction = UIAction(title: "İptal", image: UIImage(systemName: "xmark")) { action in
                print("İptal butonuna basıldı")
            }
            
            return UIMenu(title: "Ürünü silmek istediğine emin misin?", children: [deleteAction, addToFavoritesAction, cancelAction])
        }
    }
}
