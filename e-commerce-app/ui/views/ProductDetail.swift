//
//  ProductDetail.swift
//  e-commerce-app
//
//  Created by Esra Türk on 8.10.2024.
//

import UIKit
import RxSwift

class ProductDetail: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    var product: Urunler?
    var viewModel = ProductDetailViewModel()
    var cartItemList = [UrunlerSepeti]()
    var reviewCount: Int?
    
    var quantity = 1 {
         didSet {
             productQuantityLabel.text = "\(quantity)"
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pr = product {
            ImageHelper.showImage(for: productImageView, urlString: pr.resim)
            productNameLabel.text = pr.ad
            productBrandLabel.text = pr.marka
            productPriceLabel.text = "\(pr.fiyat!) ₺"
            reviewsLabel.text = "\(reviewCount ?? 0)"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeCartItems()
    }
    
    @IBAction func decreaseQuantityLabel(_ sender: UIButton) {
        if quantity > 1 {
            quantity -= 1
        }
    }
    
    @IBAction func increaseQuantityLabel(_ sender: UIButton) {
        quantity += 1
    }
    
    
    @IBAction func discount100Tapped(_ sender: Any) {
        DiscountManager.shared.discountAmount = 100
    }
    
    @IBAction func discount250Tapped(_ sender: Any) {
        DiscountManager.shared.discountAmount = 250
    }
    
    
    @IBAction func discount500Tapped(_ sender: Any) {
        DiscountManager.shared.discountAmount = 500
    }
    
    
    @IBAction func addToCartButton(_ sender: Any) {
        guard let product = product else { return }
            
        viewModel.updateOrAddCartItem(name: product.ad!,
                            photo: product.resim!,
                            category: product.kategori!,
                            price: product.fiyat!,
                            brand: product.marka!,
                            orderQuantity: quantity)
        
    }
    
    func observeCartItems() {
        _ = viewModel.cartItemList
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.cartItemList = list
                DispatchQueue.main.async {
                    self?.productQuantityLabel.text = "1"
                    
                }
            })
            .disposed(by: viewModel.disposeBag)
    }

}
