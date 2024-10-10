//
//  ProductDetail.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit

class ProductDetail: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var product: Urunler?
    var viewModel = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pr = product {
            ImageHelper.showImage(for: productImageView, urlString: pr.resim)
            productNameLabel.text = pr.ad
            productBrandLabel.text = pr.marka
            productPriceLabel.text = "\(pr.fiyat!) ₺"
        }
        
    }
    

    @IBAction func addToCartButton(_ sender: Any) {
        guard let product = product else { return }
            
        viewModel.addToCart(name: product.ad!,
                            photo: product.resim!,
                            category: product.kategori!,
                            price: product.fiyat!,
                            brand: product.marka!,
                            orderQuantity: 1)
    }
}
