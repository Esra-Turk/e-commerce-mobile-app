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
    @IBOutlet weak var stepper: UIStepper!
    
    var product: Urunler?
    var viewModel = ProductDetailViewModel()
    var cartItemList = [UrunlerSepeti]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pr = product {
            ImageHelper.showImage(for: productImageView, urlString: pr.resim)
            productNameLabel.text = pr.ad
            productBrandLabel.text = pr.marka
            productPriceLabel.text = "\(pr.fiyat!) ₺"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeCartItems()
        self.stepper.value = 1.0
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        productQuantityLabel.text = "\(Int(stepper.value))"
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        guard let product = product else { return }
            
        viewModel.updateOrAddCartItem(name: product.ad!,
                            photo: product.resim!,
                            category: product.kategori!,
                            price: product.fiyat!,
                            brand: product.marka!,
                            orderQuantity: Int(stepper.value))
        
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
